import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderUserId;
  final String senderUserName;
  final String receiverUserID;
  final String message;
  final Timestamp timestamp;

  Message({ required this.senderUserId, required this.senderUserName, required this.receiverUserID, required this.message, required this.timestamp });

  Map<String, dynamic> toMap() {
    return {
      'senderUserId': senderUserId,
      'senderUserName': senderUserName,
      'receiverUserID': receiverUserID,
      'message': message,
      'timestamp': timestamp
    };
  }

}