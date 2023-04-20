import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:amir/models/catalogues_model.dart';
import 'package:http/http.dart' as http;
import 'package:amir/models/user_model.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:amir/Services/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class CataloguesController {
  List<Catalogues> results = [];
  final _storage = const FlutterSecureStorage();
  Future<List<Catalogues>> getAllcatalogues() async {
     Dio.Response response = await dio().get('/catalogues');
    if (response.statusCode == 200) {
      return cataloguesFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }

  Stream<List<Catalogues>> getStreamData(Duration refreshTime) async* {
    String? tokens = await _storage.read(key: 'token');
    if (tokens != null) {
      while (true) {
        await Future.delayed(refreshTime);
        yield await getAllcatalogues();
      }
    }
  }
     void createCatalogues(String year,String name,File? file) async {
        String fileName = file!.path.split('/').last;
    var formData = Dio.FormData.fromMap({
        "image": await Dio.MultipartFile.fromFile(file.path, filename:fileName),
        "college_year": year,
        "name_catalogue": name,
    });
    try {
      Dio.Response response = await dio().post('/catalogues', data: formData);
      if (response.statusCode == 201) {
        
        Get.snackbar("Succès", "félicitations votre compte a été créé avec succès",
            backgroundColor: Colors.green , colorText: Colors.white);

      } else {
        Get.snackbar("Erreur", response.data['errors'][0]['msg'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteUser(String id) async {
    try {
      Dio.Response response = await dio().delete('/users/$id');
      if (response.statusCode == 204) {
        Get.snackbar("success", "utilisateur a étes suprimer",
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
