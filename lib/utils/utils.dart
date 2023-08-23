import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickimage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return file.readAsBytes();
  }
}

showSnackBar(content, BuildContext context) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.amber[200],
        content: Text(
          content,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
