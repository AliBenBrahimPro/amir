List<ModelMessage> modelMessageFromJson(dynamic str) =>
    List<ModelMessage>.from((str).map((x) => ModelMessage.fromJson(x)));


class ModelMessage {
    List<dynamic> readBy;
    String id;
    Sender sender;
    String content;
    ModelChat chat;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    ModelMessage({
        required this.readBy,
        required this.id,
        required this.sender,
        required this.content,
        required this.chat,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory ModelMessage.fromJson(Map<String, dynamic> json) => ModelMessage(
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        chat: ModelChat.fromJson(json["chat"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "chat": chat.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ModelChat {
    bool isGroupChat;
    List<String> users;
    String id;
    String chatName;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String latestMessage;

    ModelChat({
        required this.isGroupChat,
        required this.users,
        required this.id,
        required this.chatName,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.latestMessage,
    });

    factory ModelChat.fromJson(Map<String, dynamic> json) => ModelChat(
        isGroupChat: json["isGroupChat"],
        users: List<String>.from(json["users"].map((x) => x)),
        id: json["_id"],
        chatName: json["chatName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"],
    );

    Map<String, dynamic> toJson() => {
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x)),
        "_id": id,
        "chatName": chatName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage,
    };
}

class Sender {
    String id;
    String first_name;
    String email;

    Sender({
        required this.id,
        required this.first_name,
        required this.email,
    });

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        first_name: json["first_name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": first_name,
        "_id": id,
        "email": email,
    };
}
