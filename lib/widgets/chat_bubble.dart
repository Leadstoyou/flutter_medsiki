import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final String time;

  const ChatBubble({Key? key, required this.text, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          SizedBox(height: 8),
          Text(
            time,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}