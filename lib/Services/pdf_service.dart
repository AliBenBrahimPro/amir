import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:amir/models/user_model.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:amir/Services/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/pdf_model.dart';

class PdfController {
  List<Pdf> results = [];
  final _storage = const FlutterSecureStorage();
  Future<List<Pdf>> getAllPdf() async {
    Dio.Response response = await dio().get('/pdfs');
    if (response.statusCode == 200) {
      return pdfFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }

  Future<List<Pdf>> getSpecPdf(String? id) async {
    Dio.Response response = await dio().get('/catalogues/$id/pdfs');
    if (response.statusCode == 200) {
      return pdfFromJson(response.data["data"]);
    } else {
      throw Exception("failed");
    }
  }

  Stream<List<Pdf>> getStreamData(Duration refreshTime) async* {
    String? tokens = await _storage.read(key: 'token');
    if (tokens != null) {
      while (true) {
        await Future.delayed(refreshTime);
        yield await getAllPdf();
      }
    }
  }

  void createPdf(String number, String? idLecons,
      File? file) async {
      
    String fileName = file!.path.split('/').last;
    var formData = Dio.FormData.fromMap({
      "number": number,
      "file": await Dio.MultipartFile.fromFile(file.path, filename: fileName),
      "id_lecons": idLecons,
    });
    try {
      Dio.Response response = await dio().post('/pdfs', data: formData);
      if (response.statusCode == 201) {
        Get.snackbar(
            "Succès", "félicitations le domaine a été créé avec succès",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Erreur", response.data['errors'][0]['msg'],
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deletePdf(String id) async {
    try {
      Dio.Response response = await dio().delete('/pdfs/$id');
      if (response.statusCode == 204) {
        Get.snackbar("success", "pdf a étes suprimer",
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
