import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:amir/screen/enseigne/Model/chat_model.dart';
import 'package:amir/screen/enseigne/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import '../services/dio.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    if (kIsWeb) {
      _emailController.text = "benbrahimali23@gmail.com";
    _passwordController.text = "12345678";
    }else{
      _emailController.text = "alibenbrahimpro@gmail.com";
    _passwordController.text = "12345678";
    }
    
    
    super.initState();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      String email = _emailController.text;
      String password = _passwordController.text;

try {
    
    
      Dio.Response response = await dio().post('/user/login',data: { "email":email, "password":password });
      if (response.statusCode == 200) {
         SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data['token']);
    await prefs.setString('user', jsonEncode(response.data));

    Navigator.pushReplacement(context,MaterialPageRoute<void>(
      builder: (BuildContext context) =>  HomeScreenEnseigne(sourceChat:ChatModel(id:response.data['_id'],name:response.data['name'],isGroup: false,currentMessage: "" , ),token: response.data['token'], ),
    ),);
      }} catch (e) {
      log(e.toString());
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body:
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
