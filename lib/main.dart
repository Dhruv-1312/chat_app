import 'package:chat_app/screens/Signup.dart';
import 'package:chat_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyADCdY20ovK8QGKB5wXlSGrkBsN8e2FFhk",
            authDomain: "chatapp-a234b.firebaseapp.com",
            projectId: "chatapp-a234b",
            storageBucket: "chatapp-a234b.appspot.com",
            messagingSenderId: "767114857877",
            appId: "1:767114857877:web:f8ef6ea50dc2d5493a3a9c"));
  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
    );
  }
}
