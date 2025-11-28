import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sani_talk/common/widgets/custom_container.dart';
import 'package:sani_talk/common/widgets/custom_divider.dart';
import 'package:sani_talk/common/widgets/custom_elevated_button.dart';
import 'package:sani_talk/common/widgets/custom_snackbar.dart';
import 'package:sani_talk/common/widgets/custom_textfield.dart';
import 'package:sani_talk/common/widgets/login_options.dart';
import 'package:sani_talk/core/constant/widget/custom_text.dart';
import 'package:sani_talk/features/auth/provider/auth_provider.dart';
import 'package:sani_talk/features/auth/services/auth_method.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(authStateNotifierProvider);
    final formNotifier = ref.read(
      authStateNotifierProvider.notifier,
    );
    final authMethod = ref.read(authMethodProvider);

    void signUp() async {
      formNotifier.setLoading(true);
      final String res = await authMethod.signUpUser(
        email: formState.email,
        password: formState.password,
        name: formState.name,
      );
      formNotifier.setLoading(false);
      if (!context.mounted) return;
      if (res == 'success') {
        context.go('/home');
        CustomSnackbar.show(
          context,
          message: 'Sign Up Successful.',
        );
      } else {
        CustomSnackbar.show(context, message: res);
      }
    }

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
                    onChange: (value) =>
                        formNotifier.updateUserName(value),
                    icon: Icons.person_outline,
                    labelText: 'Username',
                    errortext: formState.nameError,
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    obscureText: false,
                    onChange: (value) =>
                        formNotifier.updateUserEmail(value),
                    icon: Icons.email_outlined,
                    labelText: 'Enter Email',
                    errortext: formState.emailError,
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    obscureText: true,
                    onChange: (value) => formNotifier
                        .updateUserPassword(value),
                    icon: Icons.lock_outlined,
                    labelText: 'Enter Password',
                    errortext: formState.passwordError,
                  ),
                  const SizedBox(height: 10),
                  formState.isLoading
                      ? Center(
                          child:
                              CircularProgressIndicator(),
                        )
                      : CustomElevatedButton(
                          text: 'Sign Up',
                          onTab: formState.isFormValid
                              ? signUp
                              : null,
                        ),
                  const SizedBox(height: 15),
                  CustomText(
                    text1: 'Already have an account? ',
                    text2: 'Login',
                    onTab: () {
                      context.go('/login');
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
