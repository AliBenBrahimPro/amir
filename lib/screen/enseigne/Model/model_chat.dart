// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

List<Chat> chatFromJson(dynamic str) =>
    List<Chat>.from((str).map((x) => Chat.fromJson(x)));



class Chat {
    bool isGroupChat;
    List<User> users;
    String id;
    String chatName;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    LatestMessage? latestMessage;

    Chat({
        required this.isGroupChat,
        required this.users,
        required this.id,
        required this.chatName,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
         this.latestMessage,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        isGroupChat: json["isGroupChat"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        id: json["_id"],
        chatName: json["chatName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: LatestMessage.fromJson(json["latestMessage"]?? {}),
    );

    Map<String, dynamic> toJson() => {
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "_id": id,
        "chatName": chatName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage!.toJson(),
    };
}

class LatestMessage {
    List<dynamic> readBy;
    String id;
    Sender sender;
    String content;
    String chat;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    LatestMessage({
        required this.readBy,
        required this.id,
        required this.sender,
        required this.content,
        required this.chat,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        readBy: List<dynamic>.from(json["readBy"]?? [].map((x) => x)),
        id: json["_id"]??"",
        sender: Sender.fromJson(json["sender"]??{}),
        content: json["content"]??"",
        chat: json["chat"]??"",
        createdAt: DateTime.parse(json["createdAt"]??"2000-01-01"),
        updatedAt: DateTime.parse(json["updatedAt"]??"2000-01-01"),
        v: json["__v"]??0,
    );

    Map<String, dynamic> toJson() => {
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "chat": chat,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Sender {
    String last_name;
    String id;
    String first_name;
    String email;

    Sender({
        required this.last_name,
        required this.id,
        required this.first_name,
        required this.email,
    });

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        last_name: json["last_name"]??"",
        id: json["_id"]??"",
        first_name: json["first_name"]??"",
        email: json["email"]??"",
    );

    Map<String, dynamic> toJson() => {
        "last_name": last_name,
        "_id": id,
        "first_name": first_name,
        "email": email,
    };
}

class User {
    String last_name;
    String id;
    String first_name;
    String email;
    int v;

    User({
        required this.last_name,
        required this.id,
        required this.first_name,
        required this.email,
        required this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        last_name: json["last_name"],
        id: json["_id"],
        first_name: json["first_name"],
        email: json["email"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "last_name": last_name,
        "_id": id,
        "first_name": first_name,
        "email": email,
        "__v": v,
    };
}
