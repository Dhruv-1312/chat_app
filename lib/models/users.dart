import 'package:flutter/material.dart';

class Users {
  final String name;
  final String email;
  final String phoneno;
  final String password;
  final String photourl;
  final String uid;

  const Users({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneno,
    required this.photourl,
    required this.uid,
  });

  Map<String, dynamic> toJason() => {
        'name': name,
        'email': email,
        'password': password,
        'phoneNo': phoneno,
        'photourl': photourl,
        'uid': uid,
      };
}
