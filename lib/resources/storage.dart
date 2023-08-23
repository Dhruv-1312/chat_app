import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String childname, Uint8List file) async {

      Reference ref = _storage
          .ref()
          .child(childname)
          .child(FirebaseAuth.instance.currentUser!.uid);

          String id=Uuid().v1();
          ref=ref.child(id);

          UploadTask upload=ref.putData(file);
          TaskSnapshot snap=await upload;

          String getdownloadurl=  await snap.ref.getDownloadURL();
          return getdownloadurl;
  }
}
