import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double portion;
  final String image;
  final Color color;
  const CustomContainer({
    super.key,
    required this.portion,
    required this.color,
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
            color: color,
            blurRadius: 15,
            spreadRadius: 20,
          ),
        ],
      ),
      child: Image.asset(image, fit: BoxFit.cover),
    );
  }
}
