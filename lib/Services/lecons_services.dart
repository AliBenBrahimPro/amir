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

import '../models/lecons_model.dart';

class LeconsController {
  List<Lecons> results = [];
  final _storage = const FlutterSecureStorage();
  Future<List<Lecons>> getAllLecons() async {
     Dio.Response response = await dio().get('/lecons');
    if (response.statusCode == 200) {
      return leconsFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }


  Stream<List<Lecons>> getStreamData(Duration refreshTime) async* {
    String? tokens = await _storage.read(key: 'token');
    if (tokens != null) {
      while (true) {
        await Future.delayed(refreshTime);
        yield await getAllLecons();
      }
    }
  }
    
void createLecons(Map formData) async {
    
    try {
      Dio.Response response = await dio().post('/lecons', data: formData);
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

  

  Future deleteLecons(String id) async {
    try {
      Dio.Response response = await dio().delete('/lecons/$id');
      if (response.statusCode == 204) {
        Get.snackbar("success", "lecons a étes suprimer",
            backgroundColor: Colors.green, colorText: Colors.white);
        //return true;
      } else {
        Get.snackbar("erruer", "il y a un probleme");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Lecons>> getSpecLecons(String? id) async {
     Dio.Response response = await dio().get('/chapitres/$id/lecons');
    if (response.statusCode == 200) {
      return leconsFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }
}
