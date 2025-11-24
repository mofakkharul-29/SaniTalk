import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onTab;
  final String text;
  const CustomElevatedButton({
    super.key,
    required this.onTab,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onTab,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
        elevation: 1,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
        fixedSize: Size(screenWidth, 50),
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
