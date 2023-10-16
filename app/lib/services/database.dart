import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safespace/models/chat.dart';

class DatabaseService extends ChangeNotifier {

  final String? uid;
  DatabaseService({ required this.uid });

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String name, String email) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email
    });
  }

  List<Chat> _chatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      dynamic data = doc.data()! as Map<String, dynamic>;
      return Chat(uid: data['uid'], name: data['name']);
    }).toList();
  }

  Stream<List<Chat>> get chats {
    return userCollection.where("uid", isNotEqualTo: uid).snapshots().map(_chatListFromSnapshot);
  }

}