import 'package:flutter/material.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tColor,
      body: Center(child: Text('Chat Screen')),
    );
  }
}
