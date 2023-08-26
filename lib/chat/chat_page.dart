import 'package:chat_app/chat/chatBubble.dart';
import 'package:chat_app/chat/chat_services.dart';
import 'package:chat_app/screens/mobilescreen.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/widgets/colors.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverid;
  const ChatPage({super.key, required this.receiverid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    receiverdata();
  }

  final TextEditingController msgController = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  var userdata = {};

  receiverdata() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.receiverid)
          .get();
      userdata = snap.data()!;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  sendmessage() async {
    if (msgController.text.isNotEmpty) {
      await _chatServices.sendMessage(widget.receiverid, msgController.text);
    }
    msgController.clear();
  }

  Widget buildListitem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Container(
      child: Column(
        crossAxisAlignment:
            (data['senderid'] == FirebaseAuth.instance.currentUser!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start),
        children: [
          ChatBubble(message: data['message'], colr: Colors.grey),
        ],
      ),
    );
  }

  Widget buildList() {
    return StreamBuilder(
      stream: _chatServices.getMessage(
          FirebaseAuth.instance.currentUser!.uid, widget.receiverid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryLightColor,
            ),
          );
        }
        return ListView(
            children: snapshot.data!.docs
                .map((document) => buildListitem(document))
                .toList());
      },
    );
  }

  Widget buildinput() {
    return Row(
      children: [
        Expanded(
          child: Newtextfield(
              control: msgController, hinttext: 'Type your message'),
        ),
        IconButton(
          onPressed: sendmessage,
          icon: const Icon(
            Icons.send_rounded,
            size: 30,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MobileScreen())),
        ),
        title: Text(
          userdata['name'],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: buildList()),
          buildinput(),
        ],
      ),
    );
  }
}
