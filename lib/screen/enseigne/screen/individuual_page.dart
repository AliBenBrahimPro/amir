import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import '../CustomUI/OwnMessageCard.dart';
import '../CustomUI/ReplyCard.dart';
import '../Model/MessageModel.dart';
import '../Model/chat_model.dart';
import '../Model/message_response.dart';
import '../Model/model_chat.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel sourceChat;

  const IndividualPage(
      {super.key, required this.chatModel, required this.sourceChat});
  final Chat chatModel;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool _showEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  bool sendButton = false;
  List<MessageModel> messages = [];
  final List<MessageModel> _items = [];
  late IO.Socket socket;
  ScrollController _scrollController = ScrollController();

  Future<List<MessageModel>> getChat(String sourceId, String targetId) async {
    try {
      final response = await http.get(
          Uri.parse(
              'http://192.168.1.27:3000/api/messages/$sourceId/$targetId'),
          headers: {
            'Content-Type': 'application/json',
          });
      final data = messagesResponseFromJson(response.body);
      print(data.msj);
      return data.msj;
    } catch (e) {
      return [];
    }
  }

  void _loadingChat(String sourceId, String targetId) async {
    List<MessageModel> chat = await getChat(sourceId, targetId);
    final history = chat.map((m) => MessageModel(
        message: m.message,
        sourceId: m.sourceId,
        time: m.time.substring(0, 16),
        groupChat: m.groupChat, //
        name: m.name,
        targetId: m.targetId));
    setState(() {
      _items.insertAll(0, history);
    });
  }

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          _showEmojiPicker = false;
        });
      }
    });
    _loadingChat("64e4a2581d85b75b240f86d0", widget.chatModel.id);
  }

  void connect() {
    socket = IO.io('http://192.168.1.27:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage(
            msg["targetId"], msg["message"], msg['time'], msg["sourceId"]);
        _scrollController.animateTo(_scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  void sendMessage(
      String message, String sourceId, String targetId, String time, String name) {
    DateTime now = DateTime.now();

    setMessage(targetId, message, DateTime.now().toString().substring(0, 16),
        sourceId);
    socket.emit('message', {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "time": DateTime.now().toString().substring(0, 16),
      "name": name,
      "groupChat": false
    });
  }

  void setMessage(String targetId, String message, String time, String sourceId) {
    MessageModel messageModel = MessageModel(
        message: message, targetId: targetId, time: time, sourceId: sourceId);
    setState(() {
      _items.insert(0, messageModel);
    });
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
              onTap: () => Navigator.pop(context),
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
                          ? "asset/icons/groups.svg"
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
                        widget.chatModel.chatName,
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
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height - 180,
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: _items.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _items.length) {
                        return Container(
                          height: 70,
                        );
                      }
                      if (_items[index].sourceId == widget.sourceChat.id) {
                        return OwnMessageCard(
                          message: _items[index].message,
                          time: _items[index].time,
                        );
                      } else {
                        return ReplayCard(
                            message: _items[index].message,
                                      time: _items[index].time,
                                      isGroup: widget.chatModel.isGroupChat,
                                      name:'${_items[index].name}',
                        );
                      }
                    },
                  ),
                ),
                const Divider(height: 10, thickness: 2),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width - 65,
                                child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextFormField(
                                      onTap: () {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.minScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                      },
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Type a message',
                                          prefixIcon: IconButton(
                                            icon: const Icon(
                                                Icons.emoji_emotions),
                                            onPressed: () {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                              setState(() {
                                                _showEmojiPicker =
                                                    !_showEmojiPicker;
                                              });
                                            },
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (builder) =>
                                                            buttomSheet());
                                                  },
                                                  icon: const Icon(
                                                      Icons.attach_file)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.camera_alt))
                                            ],
                                          )),
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, right: 2, left: 2),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: const Color(0xFF128C7E),
                                child: IconButton(
                                    onPressed: () {
                                      if (sendButton) {
                                        DateTime now = DateTime.now();
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.minScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                            textEditingController.text,
                                            "64e4a2581d85b75b240f86d0",
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
                )
              ]),
            ),
          ),
        ),
      ],
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
