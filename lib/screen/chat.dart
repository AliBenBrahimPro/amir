import 'package:flutter/material.dart';
import 'package:amir/utils/data.dart';
import 'package:amir/widgets/chat_item.dart';
import 'package:amir/widgets/custom_textfield.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return getChats();
  }

  getChats() {
    return ListView(
        shrinkWrap: true,
        children: List.generate(
            chats.length,
            (index) => ChatItem(
                  chats[index],
                  onTap: () {},
                )));
  }
}
