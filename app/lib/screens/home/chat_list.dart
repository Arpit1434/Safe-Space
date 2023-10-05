import 'package:flutter/material.dart';
import 'package:safespace/models/chat.dart';
import 'package:provider/provider.dart';
import 'package:safespace/screens/home/chat_tile.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<List<Chat>>(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatTile(chat: chats[index]);
      },
    );
  }
}