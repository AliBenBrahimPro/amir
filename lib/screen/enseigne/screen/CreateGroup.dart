import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../models/user_model.dart';
import '../CustomUI/AvatarCard.dart';
import '../CustomUI/ContactCard.dart';
import '../Model/chat_model.dart';
import '../Model/model_chat.dart';
import '../services/chat_services.dart';
import 'gptscreen.dart';

class CreateGroup extends StatefulWidget {
  List<UsersModel> userModel;
  ChatModel sourceChat;
  String token;
  CreateGroup(
      {super.key,
      required this.userModel,
      required this.sourceChat,
      required this.token});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupNameController = TextEditingController();
  ChatController chatController = ChatController();

  List<UsersModel> groups = [];
  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create Group"),
          content: TextField(
            controller: groupNameController,
            decoration: InputDecoration(
              hintText: "Group Name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String groupName = groupNameController.text;
                _createGroup(groupName);
                Navigator.pop(context);
              },
              child: Text("Create Group"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createGroup(String groupName) async {
    List finalList = groups.map((e) => e.id).toList();
    finalList.add(widget.sourceChat.id);

    Chat chatModel = await chatController
        .createGroup(widget.sourceChat.id!, {"name": groupName, "users": finalList});
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
    groupNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: groups.length < 2
          ? null
          : FloatingActionButton(
              onPressed: () {
                _showCreateGroupDialog();
              },
              child: const Icon(Icons.save),
            ),
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'New group',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add participants",
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: widget.userModel.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groups.isNotEmpty ? 90 : 10,
                );
              }
              return InkWell(
                  onTap: () {
                    if (widget.userModel[index - 1].select == false) {
                      setState(() {
                        widget.userModel[index - 1].select = true;
                        groups.add(widget.userModel[index - 1]);
                      });
                    } else {
                      setState(() {
                        widget.userModel[index - 1].select = false;
                        groups.remove(widget.userModel[index - 1]);
                      });
                    }
                  },
                  child: ContactCard(chatModel: widget.userModel[index - 1]));
            },
          ),
          groups.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: widget.userModel.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (widget.userModel[index].select == true) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    groups.remove(widget.userModel[index]);
                                    widget.userModel[index].select = false;
                                  });
                                },
                                child: AvatarCard(
                                  chatModel: widget.userModel[index],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    const Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
