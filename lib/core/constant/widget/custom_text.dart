import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomText({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(
          text1,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        signUpText(),
      ],
    );
  }

  Widget signUpText() {
    return GestureDetector(
      onTap: () {
        debugPrint('tapped!');
      },
      child: Text(
        text2,
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}
