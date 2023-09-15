// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:amir/screen/enseigne/Model/MessageModel.dart';



MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  MessagesResponse({
    required this.ok,
    required this.msj,
  });

  bool ok;
  List<MessageModel> msj;

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        ok: json["ok"],
        msj: List<MessageModel>.from(json["msj"].map((x) => MessageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": List<dynamic>.from(msj.map((x) => x.toJson())),
      };
}
