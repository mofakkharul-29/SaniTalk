import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextInputType? textInputType;
  final bool obscureText;
  final IconData icon;
  final String? labelText;
  const CustomTextfield({
    super.key,
    required this.obscureText,
    this.textInputType,
    required this.icon,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      autocorrect: false,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        prefixIconColor: Colors.black,
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 13,
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
