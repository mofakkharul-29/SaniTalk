import 'package:flutter/material.dart';
import 'package:sani_talk/common/widgets/custom_container.dart';
import 'package:sani_talk/common/widgets/custom_elevated_button.dart';
import 'package:sani_talk/common/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CustomContainer(),
            const SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  CustomTextfield(
                    obscureText: false,
                    icon: Icons.email_outlined,
                    labelText: 'Enter Email',
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    obscureText: true,
                    icon: Icons.lock_outlined,
                    labelText: 'Enter Password',
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(text: 'login'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
