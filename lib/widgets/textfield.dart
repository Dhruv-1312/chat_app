import 'package:flutter/material.dart';
import 'package:chat_app/widgets/colors.dart';

class textfieldContainer extends StatelessWidget {
  final Widget child;
  const textfieldContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class Newtextfield extends StatelessWidget {
  final String hinttext;
  const Newtextfield(
      {super.key, required this.control, required this.hinttext});

  final TextEditingController control;

  @override
  Widget build(BuildContext context) {
    return textfieldContainer(
      child: TextField(
        controller: control,
        obscureText: false,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hinttext),
      ),
    );
  }
}
class RoundedButton extends StatefulWidget {
  bool isloading;
  final String text;
  final Function()? onpress;
  final Color color, textcolor;
  RoundedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onpress,
    required this.textcolor,
    required this.isloading,
  });

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      height: size.height / 15.5,
      child: ElevatedButton(
        onPressed: widget.onpress,
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(), backgroundColor: widget.color),
        child: widget.isloading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                widget.text,
                style: TextStyle(color: widget.textcolor),
              ),
      ),
    );
  }
}
