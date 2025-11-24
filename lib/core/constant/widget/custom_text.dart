import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        const Text(
          'Don\'t have account? ',
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
      child: const Text(
        'SignUp',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}
