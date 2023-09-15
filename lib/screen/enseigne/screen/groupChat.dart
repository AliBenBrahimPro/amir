import 'package:amir/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    socket = IO.io(Environment.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected to server');
    });

    // Handle group messages
    socket.on('group_message', (message) {
      print('Received message: $message');
    });
  }

void sendMessage(String groupId, String message) {

  
  socket.emit('group_message', {'groupId': groupId, 'message': message});
}


  @override
  void dispose() {
    socket.disconnect();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
      ),
      body: Column(
        children: [
          // List of users and groups (UI implementation not shown)
          // Select users to create groups
          // Chat messages (UI implementation not shown)
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Type your message...',
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  final groupId = '64df100ea1e5fe0914ae2401'; // Replace with actual group ID
                  final message = _messageController.text;
                  sendMessage(groupId, message);
                  _messageController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
