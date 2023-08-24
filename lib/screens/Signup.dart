import 'dart:typed_data';

import 'package:chat_app/resources/auth.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/mobilescreen.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_app/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernamecontrol = TextEditingController();
  final TextEditingController emailControl = TextEditingController();
  final TextEditingController phoneNoControl = TextEditingController();
  final TextEditingController passswordControl = TextEditingController();
  Uint8List? _image;
  bool isloading = false;

  selectimage() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signinuser() async {
    setState(() {
      isloading = true;
    });
    if (_image == null) {
      setState(() {
        isloading = false;
      });
      return showSnackBar('Select a profile image', context);
    }
    String res = await AuthMethods().creatNewuser(
        name: usernamecontrol.text,
        email: emailControl.text,
        passsword: passswordControl.text,
        phoneNo: phoneNoControl.text,
        file: _image!);

    setState(() {
      isloading = false;
    });
    if (res != 'success') {
      return showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MobileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SignupBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Signup',
                style: TextStyle(
                    color: kprimarycolor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Stack(
                children: [
                  (_image != null)
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(_image!),
                          radius: 50,
                        )
                      : const CircleAvatar(
                          radius: 58,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYd77KFsw2Xd6mepJr49JeM4QDX2bMmjCF0LHaviMrGQ&usqp=CAU&ec=48665698'),
                        ),
                  Positioned(
                    bottom: -10,
                    right: 1,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo_rounded),
                      onPressed: selectimage,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.0011,
              ),
              Newtextfield(
                  control: usernamecontrol, hinttext: 'Enter your name'),
              SizedBox(
                height: size.height * 0.0011,
              ),
              Newtextfield(control: emailControl, hinttext: 'Enter your email'),
              SizedBox(
                height: size.height * 0.0011,
              ),
              Newtextfield(
                  control: phoneNoControl,
                  hinttext: 'Enter your mobile number'),
              SizedBox(
                height: size.height * 0.0011,
              ),
              Newtextfield(
                  control: passswordControl, hinttext: 'Enter your password'),
              SizedBox(
                height: size.height * 0.0011,
              ),
              RoundedButton(
                  text: 'Signup',
                  color: kprimarycolor,
                  onpress: signinuser,
                  textcolor: Colors.white,
                  isloading: isloading),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: kprimarycolor, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen())),
                    child: const Text(
                      '  Log in',
                      style: TextStyle(
                          color: kprimarycolor, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignupBackground extends StatelessWidget {
  final Widget child;
  const SignupBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/Newlogin.png',
              color: kprimarycolor.withOpacity(0.6),
              width: size.width * 0.35,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/log.png',
              width: size.width * 0.35,
              color: kprimarycolor.withOpacity(0.6),
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
