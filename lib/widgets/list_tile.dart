import 'package:chat_app/chat/chat_page.dart';
import 'package:flutter/material.dart';

class Listtile extends StatelessWidget {
  final snap;
  const Listtile({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      borderOnForeground: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(snap['photourl']),
            radius: 20,
          ),
          trailing: IconButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ChatPage(receiverid: snap['uid']),
              ),
            ),
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          title: Text(
            snap['name'],
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
