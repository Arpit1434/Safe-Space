import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safespace/models/chat.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ required this.uid });

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String name) async {
    return await userCollection.doc(uid).set({
      'name': name
    });
  }

  List<Chat> _chatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      dynamic data = doc.data()! as Map<String, dynamic>;
      return Chat(name: data['name']);
    }).toList();
  }

  Stream<List<Chat>> get chats {
    return userCollection.snapshots().map(_chatListFromSnapshot);
  }

}