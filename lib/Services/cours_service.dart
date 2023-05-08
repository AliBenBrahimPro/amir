import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:amir/Services/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/cours_model.dart';

class CoursController {
  List<Cours> results = [];
  final _storage = const FlutterSecureStorage();
  Future<List<Cours>> getAllCours() async {
     Dio.Response response = await dio().get('/cours');
    if (response.statusCode == 200) {
      return coursFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }

  Stream<List<Cours>> getStreamData(Duration refreshTime) async* {
    String? tokens = await _storage.read(key: 'token');
    if (tokens != null) {
      while (true) {
        await Future.delayed(refreshTime);
        yield await getAllCours();
      }
    }
  }
    Future<List<Cours>> getSpecCours(String? id) async {
     Dio.Response response = await dio().get('/domaines/$id/cours');
    if (response.statusCode == 200) {
      return coursFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }
     void createCours(String nameCour,String description,String? idDomaine,File? file) async {
        String fileName = file!.path.split('/').last;
    var formData = Dio.FormData.fromMap({
        "name_cour":nameCour,
        "image": await Dio.MultipartFile.fromFile(file.path, filename:fileName),
        "description_cour": description,
        "id_domaine": idDomaine,
        
    });
    try {
      Dio.Response response = await dio().post('/cours', data: formData);
      if (response.statusCode == 201) {
        
        Get.snackbar("Succès", "félicitations le cours a été créé avec succès",
            backgroundColor: Colors.green , colorText: Colors.white);

      } else {
        Get.snackbar("Erreur", response.data['errors'][0]['msg'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteCours(String id) async {
    try {
      Dio.Response response = await dio().delete('/cours/$id');
      if (response.statusCode == 204) {
        Get.snackbar("success", "cours a étes suprimer",
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
