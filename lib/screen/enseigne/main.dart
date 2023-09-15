import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';


import 'Pages/login_page.dart';
import 'constant/constant_util.dart';
import 'screen/groupChat.dart';
import 'services/statusCode _service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Server Status Checker',
      home: ServerStatusPage(),
    );
  }
}

class ServerStatusPage extends StatefulWidget {
  @override
  _ServerStatusPageState createState() => _ServerStatusPageState();
}

class _ServerStatusPageState extends State<ServerStatusPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> showNoInternetAlert(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the dialog when tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet"),
          content: Text('Please check your internet connection and try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Future<Map<String, dynamic>> fetchData(BuildContext context) async {
  //   final connectivityResult = await Connectivity().checkConnectivity();

  //   if (connectivityResult == ConnectivityResult.none) {
  //     showNoInternetAlert(context);
  //     return {'success': false, 'response': 'No internet connection'};
  //   }

  //   try {
  //     final response = await http
  //         .get(Uri.parse('http://192.168.1.27:3000/api/user'), headers: {'Authorization': 'Bearer $authToken'},
  //     );
  //     switch (response.statusCode) {
  //       case 200:
  //       case 201:
  //         final result = jsonDecode(response.body);
  //         final jsonResponse = {'success': true, 'response': result};
  //         return jsonResponse;
  //       case 400:
  //         final result = jsonDecode(response.body);
  //         final jsonResponse = {'success': false, 'response': result};
  //         return jsonResponse;
  //       case 401:
  //         final jsonResponse = {
  //           'success': false,
  //           'response': ConstantUtil.UNAUTHORIZED
  //         };
  //         return jsonResponse;
  //       case 500:
  //       case 501:
  //       case 502:
  //         final jsonResponse = {
  //           'success': false,
  //           'response': ConstantUtil.SOMETHING_WRONG
  //         };
  //         return jsonResponse;
  //       default:
  //         final jsonResponse = {
  //           'success': false,
  //           'response': ConstantUtil.SOMETHING_WRONG
  //         };
  //         return jsonResponse;
  //     }
  //   } on SocketException {
  //     final jsonResponse = {
  //       'success': false,
  //       'response': ConstantUtil.NO_INTERNET
  //     };
  //     return jsonResponse;
  //   } on FormatException {
  //     final jsonResponse = {
  //       'success': false,
  //       'response': ConstantUtil.BAD_RESPONSE
  //     };
  //     return jsonResponse;
  //   } on HttpException {
  //     final jsonResponse = {
  //       'success': false,
  //       'response': ConstantUtil.SOMETHING_WRONG //Server not responding
  //     };
  //     return jsonResponse;
  //   }
  // }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  LoginPage()
    );
  }
}

void main() {
  runApp(MyApp());
}
