import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Services/auth_service.dart';

class HomeEnseigne extends StatefulWidget {
  const HomeEnseigne({super.key});

  @override
  State<HomeEnseigne> createState() => _HomeEnseigneState();
}

class _HomeEnseigneState extends State<HomeEnseigne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(
      title: Text("Enseigne page"),
      actions: [
        IconButton(onPressed: (){
            Provider.of<Auth>(context, listen: false).logout();
                            Get.offAllNamed("/login");
        }, icon: Icon(Icons.logout),)
        ]),);
  }
}