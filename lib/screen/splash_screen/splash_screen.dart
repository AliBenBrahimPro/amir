import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Services/auth_service.dart';
import '../../shared/app_colors.dart';
import '../../shared/dimensions/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    var timer = Timer(Duration(seconds: 4), () {
      readToken();
    });
  }

  void readToken() async {
    String? token = await _storage.read(key: 'token');
    String? id = await _storage.read(key: 'id');
    log(token.toString());
    token == null
        ? Get.toNamed("/login")
        : Provider.of<Auth>(context, listen: false).tryToken(token, id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: pinkColor,
          body: Container(
            height: Constants.screenHeight,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Lottie.asset(
                    "asset/lotties/learning.json",
                    width: Constants.screenWidth,
                    height: Constants.screenWidth * 0.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    "asset/lotties/loading.json",
                    height: Constants.screenWidth * 0.2,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
