import 'dart:typed_data';

import 'package:chat_app/resources/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/users.dart' as models;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> creatNewuser(
      {required String name,
      required String email,
      required String passsword,
      required String phoneNo,
      required Uint8List file}) async {
    String res = 'error';
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          passsword.isNotEmpty &&
          phoneNo.isNotEmpty &&
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: passsword);

        String photourl =
            await StorageMethods().uploadImage('profileImages', file);

        models.Users users = models.Users(
            email: email,
            name: name,
            password: passsword,
            phoneno: phoneNo,
            photourl: photourl,
            uid: _auth.currentUser!.uid);

        _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .set(users.toJason());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
