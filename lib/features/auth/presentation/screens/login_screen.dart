import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sani_talk/common/widgets/custom_container.dart';
import 'package:sani_talk/common/widgets/custom_divider.dart';
import 'package:sani_talk/common/widgets/custom_elevated_button.dart';
import 'package:sani_talk/common/widgets/custom_textfield.dart';
import 'package:sani_talk/common/widgets/login_options.dart';
import 'package:sani_talk/common/widgets/remember_me.dart';
import 'package:sani_talk/core/constant/widget/custom_text.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';

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
            CustomContainer(
              portion: 2.3,
              color: shadowColor,
              image: 'assets/images/onboarding2.jpg',
            ),
            const SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  CustomTextfield(
                    obscureText: false,
                    icon: Icons.email_outlined,
                    labelText: 'Enter Email',
                    postIcon: null,
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    obscureText: true,
                    icon: Icons.lock_outlined,
                    labelText: 'Enter Password',
                    postIcon: Icons.visibility_off_outlined,
                  ),
                  const SizedBox(height: 3),
                  RememberMe(value: false, onTab: () {}),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    text: 'Login',
                    onTab: () {},
                  ),
                  const SizedBox(height: 15),
                  CustomText(
                    text1: 'Don\'t have account? ',
                    text2: 'Sign Up',
                    onTab: () {
                      context.go('/register');
                    },
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
