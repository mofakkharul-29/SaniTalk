import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String text;
  const CustomDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        getDivider(0.0, 10.0),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        getDivider(10.0, 0.0),
      ],
    );
  }

  Widget getDivider(double? indent, double? endIndent) {
    return Expanded(
      child: Divider(
        indent: indent,
        endIndent: endIndent,
        height: 1.2,
        color: Colors.black,
        thickness: 1.5,
      ),
    );
  }
}
