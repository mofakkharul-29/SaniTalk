import 'package:flutter/material.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(
      context,
    ).size.height;
    return Container(
      height: height / 2.3,
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 15,
            spreadRadius: 20,
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/onboarding2.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
