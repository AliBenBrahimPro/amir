import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:amir/Services/dio.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../Model/model_chat.dart';

class ChatController {
  Future<List<Chat>> getAllChat( String id) async {
    Dio.Response response = await dio().get('/chat/${id}');
    if (response.statusCode == 200) {
      print(chatFromJson(response.data));
      return chatFromJson(response.data);
    } else {
      throw Exception("failed");
    }
  }

  Future<List<UsersModel>> getAllUser(String token) async {
    Dio.Response response = await dio().get('/users',
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
    if (response.statusCode == 200) {
      return userFromJson(response.data);
    } else {
      throw Exception("failed");
    }
  }

  Future<Chat> postChatModel(String id, Map data) async {
    Dio.Response response = await dio().post('/chat/${id}',
        data: data);
    if (response.statusCode == 200) {
      return Chat.fromJson(response.data);
    } else {
      throw Exception("failed");
    }
  }

  Future<Chat> createGroup(String id, Map data) async {
    Dio.Response response = await dio().post('/chat/group/$id',
        data: data);
    if (response.statusCode == 200) {
      return Chat.fromJson(response.data);
    } else {
      throw Exception("failed");
    }
  }

  void sendMessage(Map data) async {
    try {
      Dio.Response response = await dio().post('/Chat', data: data);
      if (response.statusCode == 201) {
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteChat(String id) async {
    try {
      Dio.Response response = await dio().delete('/Chat/$id');
      if (response.statusCode == 204) {
        //return true;
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }
}
