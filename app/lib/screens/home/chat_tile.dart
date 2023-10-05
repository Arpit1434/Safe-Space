import 'package:flutter/material.dart';
import 'package:safespace/models/chat.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0,),
          child: ListTile(
            onTap: () {},
            leading: Initicon(
              text: chat.name,
              elevation: 1.0,
              backgroundColor: Colors.grey.shade300,
            ),
            title: Text(chat.name),
          ),
        ),
      ),
    );
  }
}