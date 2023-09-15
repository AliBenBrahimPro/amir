import 'dart:convert';

MessageModel messageFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String sourceId;
  String targetId;
  String message;
  String time;
  String? name;
  bool? groupChat;
  MessageModel(
      {required this.message,
      required this.sourceId,
      this.name,
      required this.time,
      required this.targetId,
      this.groupChat
      });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        sourceId: json["sourceId"],
        targetId: json["targetId"],
        message: json["message"],
        groupChat: json["groupChat"],
        name: json["name"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "sourceId": sourceId,
        "targetId": targetId,
        "message": message,
        "time": time,
        "groupChat": groupChat,
        "name": name,
      };
}
