import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices extends ChangeNotifier {
  Future<void> sendMessage(String receiverid, String message) async {
    final String currentuseruid = FirebaseAuth.instance.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    Message newmessage = Message(
        senderid: currentuseruid,
        receiverid: receiverid,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentuseruid, receiverid];
    ids.sort();
    String Chatroomid = ids.join('_');

    await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(Chatroomid)
        .collection('Messages')
        .add(newmessage.toJason());
  }

   Stream<QuerySnapshot>getMessage(String userid, String otheruserid) {
      List<String> ids = [userid, otheruserid];
      ids.sort();
      String roomid = ids.join('_');
      return FirebaseFirestore.instance
          .collection('ChatRoom')
          .doc(roomid)
          .collection('Messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    }
}
