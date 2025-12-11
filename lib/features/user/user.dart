import 'package:flutter/material.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: tColor,
      body: Center(child: Text('Users Screen')),
    );
  }
}
