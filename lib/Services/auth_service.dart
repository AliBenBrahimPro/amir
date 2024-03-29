import 'dart:convert';
import 'dart:developer';
import 'package:amir/screen/enseigne/screen/home_screen.dart';
import 'package:amir/screen/navigation_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:amir/Services/dio.dart';
import 'package:amir/models/user_model.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/enseigne/Model/chat_model.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  late UsersModel? _user;
  String? _token;
  final _storage = const FlutterSecureStorage();
  bool get authenticated => _isLoggedIn;
  UsersModel? get user => _user;
  String? get token => _token;

  void login(Map creds) async {
    try {
      Dio.Response response = await dio().post('/auth/login', data: creds);
      log(response.toString());
      if (response.statusCode == 200) {
        String token = response.data['token'];
        String id = response.data['data']['_id'];
        String role = response.data['data']['role'];

        tryToken(token, id);
        _isLoggedIn = true;
        Get.snackbar("Bienvenue", "connectez-vous avec succès",
            backgroundColor: Colors.green, colorText: Colors.white);
        if (role == "eleve") {
         String? tok= await _storage.read(key: 'token');
              SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token',tok!);
    await prefs.setString('user', jsonEncode(response.data['data']));
          print(response.data['data']['_id'],);
          print(response.data['data']['first_name']);
          print(response.data['data']['last_name']);
         Get.offAll(NavigationScreen(
            email:response.data['data']['email'] ,
            role:response.data['data']['role'] ,
            lastName:response.data['data']['last_name'] ,
            firstName:response.data['data']['first_name'] ,
              token:tok!,
              sourceChat: ChatModel(
                id: response.data['data']['_id'],
                currentMessage: "",
                icon: "asset/icons/person.svg",
                isGroup: false,
                name:
                    "${response.data['data']['first_name']} ${response.data['data']['last_name']}",
                select: false,
              )));
        } else if (role == "admin") {
          Get.offAllNamed('/gestionadmin');
        } else {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data['token']);
    await prefs.setString('user', jsonEncode(response.data['data']));
          Get.offAll(Get.offAll(HomeScreenEnseigne(
              token: response.data['token'],
              sourceChat: ChatModel(
                id: response.data['data']['_id'],
                currentMessage: "",
                icon: "asset/icons/person.svg",
                isGroup: false,
                name:
                    "${response.data['data']['first_name']} ${response.data['data']['last_name']}",
                select: false,
              ))));
        }

        notifyListeners();
      } else if (response.statusCode == 401) {
        Get.snackbar("la connexion a échoué", response.data['message'],
            backgroundColor: Colors.red, colorText: Colors.white);
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  updateUser(String? token, String? id, Map creds) async {
    try {
      Dio.Response response = await dio().put('/users/$id',
          data: creds,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        tryToken(token, id);
        Get.snackbar("Succès", "Votre profile a éte modifier",
            backgroundColor: Colors.green, colorText: Colors.white);

        notifyListeners();
      } else {
        Get.snackbar("échoué", response.data['errors'][0]['msg'],
            backgroundColor: Colors.red, colorText: Colors.white);
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void signUp(Map creds) async {
    try {
      Dio.Response response = await dio().post('/auth/signup', data: creds);
      if (response.statusCode == 201) {
        Get.snackbar(
            "Succès", "félicitations votre compte a été créé avec succès",
            backgroundColor: Colors.green, colorText: Colors.white);

        notifyListeners();
      } else {
        Get.snackbar("Erreur", response.data['errors'][0]['msg'],
            backgroundColor: Colors.red, colorText: Colors.white);
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void tryToken(String? token, String? id) async {
    if (token == null) {
      return;
    } else {
      try {
        Dio.Response response = await dio().get('/users/${id}',
            options:
                Dio.Options(headers: {'Authorization': 'Bearer ${token}'}));
        String role = response.data['data']['role'];
        _isLoggedIn = true;
        _user = UsersModel.fromJson(response.data['data']);
        storeToken(token, id);
        if (role == "eleve") {
            String? tok= await _storage.read(key: 'token');
              SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token',tok!);
    await prefs.setString('user', jsonEncode(response.data['data']));
          print(response.data['data']['_id'],);
          print(response.data['data']['first_name']);
          print(response.data['data']['last_name']);
          Get.offAll(NavigationScreen(
            email:response.data['data']['email'] ,
            role:response.data['data']['role'] ,
            lastName:response.data['data']['last_name'] ,
            firstName:response.data['data']['first_name'] ,
              token:tok!,
              sourceChat: ChatModel(
                id: response.data['data']['_id'],
                currentMessage: "",
                icon: "asset/icons/person.svg",
                isGroup: false,
                name:
                    "${response.data['data']['first_name']} ${response.data['data']['last_name']}",
                select: false,
              )));
        } else if (role == "admin") {
          Get.offAllNamed('/gestionadmin');
        } else {
          String? tok= await _storage.read(key: 'token');
              SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token',tok!);
    await prefs.setString('user', jsonEncode(response.data['data']));
          print(response.data['data']['_id'],);
          print(response.data['data']['first_name']);
          print(response.data['data']['last_name']);
          Get.offAll(HomeScreenEnseigne(
              token:tok!,
              sourceChat: ChatModel(
                id: response.data['data']['_id'],
                currentMessage: "",
                icon: "asset/icons/person.svg",
                isGroup: false,
                name:
                    "${response.data['data']['first_name']} ${response.data['data']['last_name']}",
                select: false,
              )));
        }
        notifyListeners();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void storeToken(
    String? token,
    String? id,
  ) async {
    _storage.write(key: 'token', value: token);
    _storage.write(key: 'id', value: id);
  }

  void logout() async {
    cleanUp();
    notifyListeners();
  }

  void cleanUp() async {
    _user = null;
    _isLoggedIn = false;
    _token = null;
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'id');

    notifyListeners();
  }
}
