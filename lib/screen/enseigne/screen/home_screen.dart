import 'package:amir/screen/enseigne/Pages/chat_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Services/auth_service.dart';
import '../Model/chat_model.dart';

class HomeScreenEnseigne extends StatefulWidget {
  String token;
  final ChatModel sourceChat;

  HomeScreenEnseigne(
      {super.key, required this.sourceChat, required this.token});

  @override
  State<HomeScreenEnseigne> createState() => _HomeScreenEnseigneState();
}

class _HomeScreenEnseigneState extends State<HomeScreenEnseigne>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.sourceChat.name}"),
        bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _controller,
            tabs: const [
              Tab(
                text: 'CHAtS',
              ),
              Tab(
                text: 'Creer room',
              ),
            ]),
        actions: [
          IconButton(onPressed: () {
                   Provider.of<Auth>(context, listen: false).logout();
                            Get.offAllNamed("/login");
          }, icon: const Icon(Icons.logout)),
        ],
      ),
      body: TabBarView(controller: _controller, children: [
        ChatPage(sourceChat: widget.sourceChat, token: widget.token, isProf: true),
        const Text("Creer room"),
      ]),
    );
  }
}
