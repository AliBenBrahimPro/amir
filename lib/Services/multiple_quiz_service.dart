import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:amir/Services/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/multiple_quiz_model.dart';


class MultipleController {
  List<MultipQuizModel> results = [];
  final _storage = const FlutterSecureStorage();
  Future<List<MultipQuizModel>> getAllQuiz() async {
    Dio.Response response = await dio().get('/quizzs');
    if (response.statusCode == 200) {
      return multipQuizFromJson(response.data["data"]) ;
    } else {
      throw Exception("failed");
    }
  }

  Stream<List<MultipQuizModel>> getStreamData(Duration refreshTime) async* {
    String? tokens = await _storage.read(key: 'token');
    if (tokens != null) {
      while (true) {
        await Future.delayed(refreshTime);
        yield await getAllQuiz();
      }
    }
  }
   Future<MultipQuizModel> getSpecQuiz(String? id) async {
     Dio.Response response = await dio().get('/quizzs/$id');
     
       
  
    if (response.statusCode == 200) {
      
      return MultipQuizModel.fromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }  
  }

  void createQuiz(Map formData) async {
    try {
      Dio.Response response = await dio().post('/quizzs', data: formData);
      if (response.statusCode == 201) {
        Get.snackbar("Succès", "félicitations le quiz a été créé avec succès",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Erreur", response.data['errors'][0]['msg'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteQuiz(String id) async {
    try {
      Dio.Response response = await dio().delete('/quizzs/$id');
      if (response.statusCode == 204) {
        Get.snackbar("success", "quiz a étes suprimer",
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
