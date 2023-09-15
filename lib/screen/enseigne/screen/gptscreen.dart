import 'dart:convert';
import 'dart:developer';
import 'package:amir/global/environment.dart';
import 'package:amir/screen/enseigne/CustomUI/OwnMessageCard.dart';
import 'package:lottie/lottie.dart';

import 'package:dio/dio.dart' as Dio;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import '../CustomUI/ReplyCard.dart';
import '../Model/MessageModel.dart';
import '../Model/chat_model.dart';
import '../Model/message_response.dart';
import '../Model/model_chat.dart';
import '../Model/model_message.dart';
import '../services/dio.dart';

class TryByMe extends StatefulWidget {
  final ChatModel sourceChat;
  final String token;

  const TryByMe(
      {super.key,
      required this.chatModel,
      required this.sourceChat,
      required this.token});
  final Chat chatModel;

  @override
  State<TryByMe> createState() => _TryByMeState();
}

class _TryByMeState extends State<TryByMe> {
  bool _showEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  bool sendButton = false;
  bool isLoading = true;
  List<MessageModel> messages = [];
  final List<MessageModel> _items = [];
  late IO.Socket socket;
  late ScrollController _scrollController = ScrollController();
  bool typing = false;
  bool socketConnected = false;
  bool otherPersonIsTyping = false;
  

  Future<List<ModelMessage>> getOldChat(String targetId, String token) async {
    Dio.Response response = await dio().get('/message/$targetId',
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
    if (response.statusCode == 200) {
      return modelMessageFromJson(response.data);
    } else {
      throw Exception("failed");
    }
  }

  void _loadingChat(String sourceId, String targetId) async {
    List<ModelMessage> chat = await getOldChat(targetId, widget.token);
    final history = chat.map((m) => MessageModel(
        message: m.content,
        sourceId: m.sender.id,
        time:
            '${m.createdAt.year}-${m.createdAt.month}-${m.createdAt.day} ${m.createdAt.hour}:${m.createdAt.minute}',
        groupChat: m.chat.isGroupChat, //
        name: m.sender.first_name,
        targetId: m.chat.users[0] == m.sender.id
            ? m.chat.users[1]
            : m.chat.users[0]));
    setState(() {
      _items.insertAll(0, history);
      isLoading = false;
    });
    if (mounted) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  @override
  void dispose() {
    // Cancel any ongoing operations, like timers, here
    textEditingController.dispose();
    socket.off('message recieved');
    socket.off("connected");
    socket.off("setup");
    socket.off('typing'); // Remove the typing event listener
    socket.off('stop typing'); // Remove the stop typing event listener
    socket.off('join chat');

    socket.disconnect();

    _scrollController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    connect();
    setup();
    connected();

    _loadingChat(widget.sourceChat.id!, widget.chatModel.id);
    _scrollController = ScrollController();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          _showEmojiPicker = false;
        });
      }
    });
  }

  connected() {
    socket.on("connected", (msg) {
      setState(() {
        socketConnected = true;
      });
    });
  }

  Future<void> setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    socket.emit("setup", jsonEncode(prefs.get('user')));
  }

  void connect() {
    socket = IO.io(Environment.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.emit("connected", widget.sourceChat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.emit("join chat", widget.chatModel.id);
      socket.on("message recieved", (msg) {
        if (mounted) {
          setMessage(
              msg["chat"]["users"][0] == msg["sender"]['_id']
                  ? msg["chat"]["users"][1].toString()
                  : msg["chat"]["users"][0].toString(),
              msg["content"],
              "${DateTime.parse(msg['updatedAt']).year}-${DateTime.parse(msg['updatedAt']).month}-${DateTime.parse(msg['updatedAt']).day} ${DateTime.parse(msg['updatedAt']).hour}:${DateTime.parse(msg['updatedAt']).minute}",
              msg["sender"]['_id'],
              msg["sender"]['name']);
        }
      });

      socket.on('typing', (data) {
        if (mounted) {
          setState(() {
            otherPersonIsTyping = true;
          });
        }
      });

      socket.on('stop typing', (data) {
        if (mounted) {
          setState(() {
            otherPersonIsTyping = false;
          });
        }
      });
    });
    print(socket.connected);
  }

  Future<void> sendMessage(String message, String sourceId, String targetId,
      String time, String name) async {
    socket.emit("stop typing", widget.chatModel.id);

    setMessage(targetId, message, DateTime.now().toString().substring(0, 16),
        sourceId, name);
    try {
      Dio.Response response = await dio().post('/message/${sourceId}',
          data: {"content": message, "chatId": widget.chatModel.id},
          options: Dio.Options(
              headers: {'Authorization': 'Bearer ${widget.token}'}));

      if (response.statusCode == 200) {
        socket.emit('new message', {response.data});
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void setMessage(String targetId, String message, String time, String sourceId,
      String name) {
    MessageModel messageModel = MessageModel(
        message: message,
        targetId: targetId,
        time: time,
        sourceId: sourceId,
        name: name);
    if (mounted) {
      setState(() {
        _items.add(messageModel);
      });
    }
  }

  void _startTyping() {
    if (mounted) {
      socket.emit('typing', {}); // Emit typing event
    }
  }

  void _stopTyping() {
    if (mounted) {
      socket.emit('stop typing', {}); // Emit stop typing event
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'asset/images/whatsapp_Back.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
            Navigator.of(context).pop(true); // Signal to refresh when returning to SecondPage
          },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                    child: SvgPicture.asset(
                      widget.chatModel.isGroupChat
                          ? "asset/images/group.svg"
                          : "asset/icons/person.svg",
                      color: Colors.white,
                      height: 37,
                      width: 37,
                    ),
                  )
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(6),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        !widget.chatModel.isGroupChat
                            ? widget.chatModel.users[0].id ==
                                    widget.sourceChat.id
                                ? widget.chatModel.users[1].first_name
                                : widget.chatModel.users[0].first_name
                            : widget.chatModel.chatName,
                        style: const TextStyle(
                            fontSize: 18.5, fontWeight: FontWeight.bold),
                      ),
                      Text("last seen today at ${widget.chatModel.createdAt}",
                          style: const TextStyle(fontSize: 13))
                    ]),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              PopupMenuButton<String>(onSelected: (value) {
                if (kDebugMode) {
                  print(value);
                }
              }, itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: "View Contact",
                    child: Text("View Contact"),
                  ),
                  const PopupMenuItem(
                    value: "Media, links, and docs",
                    child: Text("Media, links, and docs"),
                  ),
                  const PopupMenuItem(
                    value: "Whatsapp web",
                    child: Text("Whatsapp web"),
                  ),
                  const PopupMenuItem(
                    value: "Search",
                    child: Text("Search"),
                  ),
                  const PopupMenuItem(
                    value: "Mute Notification",
                    child: Text("Mute Notification"),
                  ),
                  const PopupMenuItem(
                    value: "Wallpaper",
                    child: Text("Wallpaper"),
                  ),
                ];
              }),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (_showEmojiPicker) {
                  setState(() {
                    _showEmojiPicker = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: isLoading || !socketConnected
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : 
                  Stack(children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                                child: Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount: _items.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == _items.length) {
                                    return Container(
                                      height: 70,
                                    );
                                  }
                                  if (_items[index].sourceId ==
                                      widget.sourceChat.id) {
                                    return OwnMessageCard(
                                      message: _items[index].message,
                                      time: _items[index].time,
                                    );
                                  } else {
                                    return ReplayCard(
                                      message: _items[index].message,
                                      time: _items[index].time,
                                      isGroup: widget.chatModel.isGroupChat,
                                      name: '${_items[index].name}',
                                    );
                                  }
                                },
                              ),
                            )),
                            otherPersonIsTyping
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Lottie.asset(
                                              'asset/images/typing.json',
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            const Divider(height: 2),
                            _inputChat(),
                          ],
                        ),
                      ),
                    ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        height: 70 + (_showEmojiPicker ? 300 : 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 65,
                    child: Card(
                        margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: TextFormField(
                          onTap: () {
                            _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut);
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                _startTyping();
                                sendButton = true;
                              });
                            } else {
                              setState(() {
                                _stopTyping();

                                sendButton = false;
                              });
                            }
                          },
                          controller: textEditingController,
                          focusNode: focusNode,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type a message',
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.emoji_emotions),
                                onPressed: () {
                                  focusNode.unfocus();
                                  focusNode.canRequestFocus = false;
                                  setState(() {
                                    _showEmojiPicker = !_showEmojiPicker;
                                  });
                                },
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (builder) =>
                                                buttomSheet());
                                      },
                                      icon: const Icon(Icons.attach_file)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.camera_alt))
                                ],
                              )),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 2, left: 2),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFF128C7E),
                    child: IconButton(
                        onPressed: () {
                          if (sendButton) {
                            DateTime now = DateTime.now();
                            _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut);

                            sendMessage(
                                textEditingController.text,
                                widget.sourceChat.id!,
                                widget.chatModel.id,
                                "${now.hour}:${now.minute}",
                                widget.sourceChat.name!);
                            textEditingController.clear();
                          }
                        },
                        icon: Icon(
                          sendButton ? Icons.send : Icons.mic,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
            Visibility(
                visible: _showEmojiPicker,
                child: SizedBox(
                  height: 300,
                  child: emojiSelect(),
                ))
          ],
        ),
      ),
    );
  }

  Widget buttomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(
                    Icons.insert_drive_file, Colors.indigo, "Document"),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.insert_photo, Colors.purple, "Gallerry")
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(Icons.headset, Colors.orange, "Audio"),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.location_pin, Colors.teal, "Location"),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.person, Colors.blue, "Contact")
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      config: const Config(
        columns: 7,
      ),
      onEmojiSelected: (category, emoji) {
        setState(() {
          textEditingController.text = textEditingController.text + emoji.emoji;
        });
      },
    );
  }
}
