import 'package:flutter/material.dart';

class LoginOptions extends StatelessWidget {
  const LoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getIconButton('assets/images/google.png', () {}),
        const SizedBox(width: 20),
        getIconButton('assets/images/facebook.png', () {}),
        const SizedBox(width: 20),
        getIconButton(
          'assets/images/p.png',
          () {},
          58.0,
          58.0,
        ),
      ],
    );
  }

  Widget getIconButton(
    String image,
    void Function()? onPressed, [
    double height = 65.0,
    double width = 65.0,
  ]) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        fixedSize: Size(width, height),
        elevation: 1,
        overlayColor: Colors.transparent,
      ),
      icon: Image.asset(image),
    );
  }
}
