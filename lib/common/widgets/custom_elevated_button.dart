import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  const CustomElevatedButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
        elevation: 1,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
        fixedSize: Size(180, 50),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            style: BorderStyle.solid,
            color: Colors.black87,
            width: 1.2,
          ),
          borderRadius: BorderRadiusGeometry.circular(4),
        ),
      ),
      child: Text(text),
    );
  }
}
