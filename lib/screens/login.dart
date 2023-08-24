import 'package:chat_app/resources/auth.dart';
import 'package:chat_app/screens/Signup.dart';
import 'package:chat_app/screens/mobilescreen.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/widgets/colors.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontrol = TextEditingController();
  final TextEditingController passswordcontrol = TextEditingController();
  bool isloading = false;

  void login() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthMethods()
        .loginuser(email: emailcontrol.text, password: passswordcontrol.text);

    if (res != 'success') {
      setState(() {
        isloading = false;
      });
      showSnackBar(res, context);
      setState(() {
        isloading = false;
      });
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
      body: LoginBackgorund(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                  color: kprimarycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: size.height * 0.0112,
            ),
            Newtextfield(control: emailcontrol, hinttext: 'Enter your email'),
            SizedBox(
              height: size.height * 0.002,
            ),
            Newtextfield(
                control: passswordcontrol, hinttext: 'Enter your password'),
            SizedBox(
              height: size.height * 0.002,
            ),
            RoundedButton(
                text: 'Login',
                color: kprimarycolor,
                onpress: login,
                textcolor: Colors.white,
                isloading: isloading),
            SizedBox(
              height: size.height * 0.001,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't hava an account?",
                  style: TextStyle(color: kprimarycolor),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  ),
                  child: const Text(
                    '  Signup',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kprimarycolor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginBackgorund extends StatelessWidget {
  final Widget child;
  const LoginBackgorund({super.key, required this.child});

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
              'assets/images/main_top.png',
              width: size.width * 0.35,
              color: kprimarycolor.withOpacity(0.6),
            ),
          ),
          child
        ],
      ),
    );
  }
}
