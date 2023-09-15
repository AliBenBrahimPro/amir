import 'package:flutter/material.dart';


import '../CustomUI/ButtonCard.dart';
import '../Model/chat_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chats = [
    ChatModel(
        id: "1",
        name: "Ali",
        isGroup: false,
        currentMessage: "",
        time: "4:00",
        icon: "person.svg"),
    ChatModel(
        id: "2",
        name: "Tahani",
        isGroup: false,
        currentMessage: "",
        time: "16:00",
        icon: "person.svg"),
    ChatModel(
        id: "3",
        name: "Binomi",
        isGroup: false,
        currentMessage: "",
        time: "18:00",
        icon: "person.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  sourceChat = chats.removeAt(index);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>  HomeScreenEnseigne(sourceChat: sourceChat,token: ""),
                    ),
                  );
                },
                child:
                    ButtonCard(name: chats[index].name!, icon: Icons.person));
          }),
    );
  }
}
