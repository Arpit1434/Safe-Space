import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safespace/services/chat.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserID;
  final String receiverUserName;

  const ChatPage({super.key, required this.receiverUserID, required this.receiverUserName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.receiverUserName),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Column(
        
      ),
    );
  }
}