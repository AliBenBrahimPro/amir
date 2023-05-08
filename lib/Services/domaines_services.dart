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

import '../models/domaines_model.dart';

class DomainesController {
  List<Domaines> results = [];
  final _storage = const FlutterSecureStorage();
  Future<List<Domaines>> getAllDomaines() async {
     Dio.Response response = await dio().get('/domaines');
    if (response.statusCode == 200) {
      return domainesFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }
  Future<List<Domaines>> getSpecDomaines(String? id) async {
     Dio.Response response = await dio().get('/catalogues/$id/domaines');
    if (response.statusCode == 200) {
      return domainesFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }

  Stream<List<Domaines>> getStreamData(Duration refreshTime) async* {
    String? tokens = await _storage.read(key: 'token');
    if (tokens != null) {
      while (true) {
        await Future.delayed(refreshTime);
        yield await getAllDomaines();
      }
    }
  }
     void createDomaines(String domaine,String certificate,String? idCatalogue,File? file,String? icon) async {
        String fileName = file!.path.split('/').last;
    var formData = Dio.FormData.fromMap({
        "name_domain":domaine,
        "image": await Dio.MultipartFile.fromFile(file.path, filename:fileName),
        "certificate": certificate,
        "id_catalogue": idCatalogue,
        'icon':icon
    });
    try {
      Dio.Response response = await dio().post('/domaines', data: formData);
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

  Future deleteDomaines(String id) async {
    try {
      Dio.Response response = await dio().delete('/domaines/$id');
      if (response.statusCode == 204) {
        Get.snackbar("success", "domaines a étes suprimer",
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
