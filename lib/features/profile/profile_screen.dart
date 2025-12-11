import 'package:flutter/material.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: tColor,
      body: Center(child: Text('Profile Screen')),
    );
  }
}
