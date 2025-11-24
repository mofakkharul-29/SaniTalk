import 'package:flutter/material.dart';
import 'package:sani_talk/common/widgets/custom_container.dart';
import 'package:sani_talk/common/widgets/custom_divider.dart';
import 'package:sani_talk/common/widgets/custom_elevated_button.dart';
import 'package:sani_talk/common/widgets/custom_textfield.dart';
import 'package:sani_talk/common/widgets/login_options.dart';
import 'package:sani_talk/core/constant/widget/custom_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CustomContainer(
              portion: 2.8,
              color: const Color.fromARGB(
                255,
                202,
                200,
                200,
              ),
              image: 'assets/images/ob.jpg',
            ),
            const SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  CustomTextfield(
                    obscureText: false,
                    icon: Icons.person_outline,
                    labelText: 'Username',
                  ),
                  const SizedBox(height: 8),
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
                  CustomElevatedButton(
                    text: 'SignUp',
                    onTab: () {},
                  ),
                  const SizedBox(height: 15),
                  CustomText(
                    text1: 'Already have an account? ',
                    text2: 'SignIn',
                  ),
                  const SizedBox(height: 5),
                  CustomDivider(text: 'OR'),
                  const SizedBox(height: 10),
                  LoginOptions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
