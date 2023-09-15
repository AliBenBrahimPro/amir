double isSameSenderMargin(List<Message> messages, Message m, int i, String userId) {
  if (i < messages.length - 1 &&
      messages[i + 1].sender.id == m.sender.id &&
      messages[i].sender.id != userId) {
    return 33.0;
  } else if ((i < messages.length - 1 &&
          messages[i + 1].sender.id != m.sender.id &&
          messages[i].sender.id != userId) ||
      (i == messages.length - 1 && messages[i].sender.id != userId)) {
    return 0.0;
  } else {
    return double.infinity; // Set to a large value to mimic "auto" behavior
  }
}

bool isSameSender(List<Message> messages, Message m, int i, String userId) {
  return i < messages.length - 1 &&
      (messages[i + 1].sender.id != m.sender.id ||
          messages[i + 1].sender.id == null) &&
      messages[i].sender.id != userId;
}

bool isLastMessage(List<Message> messages, int i, String userId) {
  return i == messages.length - 1 &&
      messages[messages.length - 1].sender.id != userId &&
      messages[messages.length - 1].sender.id != null;
}

bool isSameUser(List<Message> messages, Message m, int i) {
  return i > 0 && messages[i - 1].sender.id == m.sender.id;
}

String getSender(User loggedUser, List<User> users) {
  return users[0].id == loggedUser.id ? users[1].name : users[0].name;
}

User getSenderFull(User loggedUser, List<User> users) {
  return users[0].id == loggedUser.id ? users[1] : users[0];
}

class Message {
  final User sender; // Replace with your User class
  final String text;

  Message({required this.sender, required this.text});
}

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});
}
