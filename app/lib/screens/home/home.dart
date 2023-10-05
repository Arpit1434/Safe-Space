import 'package:flutter/material.dart';
import 'package:safespace/models/chat.dart';
import 'package:safespace/models/safespace_user.dart';
import 'package:safespace/screens/home/chat_list.dart';
import 'package:safespace/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:safespace/services/database.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SafeSpaceUser>(context);

    return StreamProvider<List<Chat>>.value(
      initialData: [],
      value: DatabaseService(uid: user.uid).chats,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Safe Space'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  "Suggestions",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              ChatList()
            ]
          ),
        ),
    );
  }
}