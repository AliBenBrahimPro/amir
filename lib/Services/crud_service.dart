import 'dart:convert';
import 'package:amir/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

final String url = "http://172.28.112.1:3000/api/users";

List<UsersModel> parseUser(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var users = list.map((e) => UsersModel.fromJson(e)).toList();
  return users;
}

Future<List<UsersModel>> fetchUsers() async{
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return compute(parseUser,response.body);
  } else {
    throw Exception(response.statusCode);
  }
}