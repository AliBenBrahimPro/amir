import 'dart:async';

import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../CustomUI/custom_card.dart';
import '../Model/chat_model.dart';
import '../Model/model_chat.dart';
import '../services/chat_services.dart';
import 'SelectContact.dart';

class ChatPage extends StatefulWidget {
  final ChatModel sourceChat;
  bool isProf;
  String token;

  ChatPage({super.key, required this.sourceChat, required this.token,required this.isProf});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // late IO.Socket socket;
  // @override
  // void initState() {
  //   connectSocket();
  //   super.initState();
  // }

  // void connectSocket() {
  //   socket = IO.io('http://192.168.1.27:3000', <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': false,
  //   });
  //   socket.connect();

  //   socket.on('message received', (data) {
  //     setState(() {
  //       // Update your chat list with the new message
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   socket.disconnect();
  //   super.dispose();
  // }

  ChatController chatController = ChatController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:widget.isProf? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => SelectContact(
                  token: widget.token, sourceChat: widget.sourceChat),
            ),
          );
        },
        child: const Icon(Icons.chat),
      ):null,
      body: FutureBuilder<List<Chat>>(
          future: chatController.getAllChat(widget.sourceChat.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.data!);
              return Center(child: Text(snapshot.error.toString()));
            } else {
              final response = snapshot.data!;
              return ListView.builder(
                  itemCount: response.length,
                  itemBuilder: (context, index) => CustomCard(
                        chatModel: response[index],
                        sourceChat: widget.sourceChat,
                        token: widget.token,
                      ));
            }
          }),
    );
  }
}
