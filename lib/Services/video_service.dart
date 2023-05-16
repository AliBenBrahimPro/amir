import 'dart:developer';
import 'package:dio/dio.dart' as Dio;
import 'package:amir/Services/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/video_model.dart';

class VideosController {
  List<Videos> results = [];
  final _storage = const FlutterSecureStorage();
  Future<List<Videos>> getAllVideos() async {
    Dio.Response response = await dio().get('/videos');
    if (response.statusCode == 200) {
      return videosFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }

  Future<List<Videos>> getSpecVideos(String? id) async {
    Dio.Response response = await dio().get('/lecons/$id/videos');
    if (response.statusCode == 200) {
      return videosFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }

  Stream<List<Videos>> getStreamData(Duration refreshTime) async* {
    String? tokens = await _storage.read(key: 'token');
    if (tokens != null) {
      while (true) {
        await Future.delayed(refreshTime);
        yield await getAllVideos();
      }
    }
  }

  void createVideos(Map creeds) async {
      
   
    try {
      Dio.Response response = await dio().post('/videos', data: creeds);
      if (response.statusCode == 201) {
        Get.snackbar(
            "Succès", "félicitations le video a été créé avec succès",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Erreur", response.data['errors'][0]['msg'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteVideos(String id) async {
    try {
      Dio.Response response = await dio().delete('/videos/$id');
      if (response.statusCode == 204) {
        Get.snackbar("success", "videos a étes suprimer",
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
