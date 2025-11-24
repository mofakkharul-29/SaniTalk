import 'package:flutter/material.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';

class CustomContainer extends StatelessWidget {
  final double portion;
  final String image;
  const CustomContainer({
    super.key,
    required this.portion,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(
      context,
    ).size.height;
    return Container(
      height: height / portion,
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
      child: Image.asset(image, fit: BoxFit.cover),
    );
  }
}
