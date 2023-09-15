import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../Model/chat_model.dart';
import '../Model/model_chat.dart';
import '../constant/chatLogic.dart' as ChatLogic;
import '../screen/gptscreen.dart';

class CustomCard extends StatelessWidget {
  final Chat chatModel;
  final ChatModel sourceChat;
  final String token;

  const CustomCard(
      {super.key,
      required this.chatModel,
      required this.sourceChat,
      required this.token});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TryByMe(
                      chatModel: chatModel,
                      sourceChat: sourceChat,
                      token: token,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: SvgPicture.asset(
                chatModel.isGroupChat
                    ? "asset/images/group.svg"
                    : "asset/icons/person.svg",
                color: Colors.white,
                height: 37,
                width: 37,
              ),
            ),
            title: Text(
                !chatModel.isGroupChat
                    ? chatModel.users[0].id == sourceChat.id
                        ? chatModel.users[1].first_name
                        : chatModel.users[0].first_name
                    : chatModel.chatName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: chatModel.latestMessage!.id != ""
                ? Row(
                    children: [
                      Text(
                        "${chatModel.latestMessage!.sender.first_name}: ",
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          chatModel.latestMessage!.content,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  )
                : Container(),
            trailing: Text(
                "${chatModel.updatedAt.hour}:${chatModel.updatedAt.minute}"),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1.2,
            ),
          )
        ],
      ),
    );
  }
}
