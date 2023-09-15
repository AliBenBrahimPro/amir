import 'package:amir/Services/user_service.dart';
import 'package:amir/screen/enseigne/CustomUI/ButtonCard.dart';
import 'package:amir/screen/enseigne/Model/chat_model.dart';
import 'package:amir/screen/enseigne/screen/CreateGroup.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../CustomUI/ContactCard.dart';
import '../Model/model_chat.dart';
import '../screen/gptscreen.dart';
import '../services/chat_services.dart';

class SelectContact extends StatefulWidget {
  ChatModel sourceChat;
  String token;
  SelectContact({super.key, required this.token, required this.sourceChat});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  ChatController chatController = ChatController();
  UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<UsersModel>>(
            future: userController.getAllEtudiant(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('somthing went wrong ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final user = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      'Select Contact',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${user.length} contacts',
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                );
               } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            }),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: "Invite a friend",
                    child: Text("Invite a friend"),
                  ),
                  const PopupMenuItem(
                    value: "Contacts",
                    child: Text("Contacts"),
                  ),
                  const PopupMenuItem(
                    value: "Refresh",
                    child: Text("Refresh"),
                  ),
                  const PopupMenuItem(
                    value: "Help",
                    child: Text("Help"),
                  ),
                ];
              }),
        ],
      ),
      body: FutureBuilder<List<UsersModel>>(
          future: userController.getAllEtudiant(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('somthing went wrong ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return ListView.builder(
                itemCount: user.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => CreateGroup(
                                userModel: user,
                                sourceChat: widget.sourceChat,
                                token: widget.token),
                          ),
                        );
                      },
                      child: const ButtonCard(
                        name: 'New group',
                        icon: Icons.group,
                      ),
                    );
                  }
                  return InkWell(
                      onTap: () async {
                        Chat chatModel = await chatController.postChatModel(
                            "${widget.sourceChat.id}", {"userId": user[index - 1].id});
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => TryByMe(
                              token: widget.token,
                              chatModel: chatModel,
                              sourceChat: widget.sourceChat,
                            ),
                          ),
                        );
                      },
                      child: ContactCard(chatModel: user[index - 1]));
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
