import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:amir/models/user_model.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:amir/Services/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/chapitres_model.dart';

class ChapitresController {
  List<Chapitres> results = [];
  final _storage = const FlutterSecureStorage();
  Future<List<Chapitres>> getAllChapitres() async {
     Dio.Response response = await dio().get('/chapitres');
    if (response.statusCode == 200) {
      return chapitresFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }


  Stream<List<Chapitres>> getStreamData(Duration refreshTime) async* {
    String? tokens = await _storage.read(key: 'token');
    if (tokens != null) {
      while (true) {
        await Future.delayed(refreshTime);
        yield await getAllChapitres();
      }
    }
  }
    Future<List<Chapitres>> getSpecChapitres(String? id) async {
     Dio.Response response = await dio().get('/cours/$id/chapitres');
    if (response.statusCode == 200) {
      return chapitresFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }
     void createChapitres(Map formData) async {
    
    try {
      Dio.Response response = await dio().post('/chapitres', data: formData);
      if (response.statusCode == 201) {
        
        Get.snackbar("Succès", "félicitations le domaine a été créé avec succès",
            backgroundColor: Colors.green , colorText: Colors.white);

      } else {
        Get.snackbar("Erreur", response.data['errors'][0]['msg'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteChapitres(String id) async {
    try {
      Dio.Response response = await dio().delete('/chapitres/$id');
      if (response.statusCode == 204) {
        Get.snackbar("success", "chapitres a étes suprimer",
            backgroundColor: Colors.green, colorText: Colors.white);
        //return true;
      } else {
        Get.snackbar("erruer", "il y a un probleme");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
