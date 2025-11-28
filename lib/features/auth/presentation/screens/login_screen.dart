import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sani_talk/common/widgets/custom_container.dart';
import 'package:sani_talk/common/widgets/custom_divider.dart';
import 'package:sani_talk/common/widgets/custom_elevated_button.dart';
import 'package:sani_talk/common/widgets/custom_snackbar.dart';
import 'package:sani_talk/common/widgets/custom_textfield.dart';
import 'package:sani_talk/common/widgets/login_options.dart';
import 'package:sani_talk/common/widgets/remember_me.dart';
import 'package:sani_talk/common/widgets/suffix_icon_button.dart';
import 'package:sani_talk/core/constant/widget/custom_text.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';
import 'package:sani_talk/features/auth/provider/auth_provider.dart';
import 'package:sani_talk/features/auth/services/auth_method.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(authStateNotifierProvider);
    final formNotifier = ref.read(
      authStateNotifierProvider.notifier,
    );
    final authMethod = ref.read(authMethodProvider);

    void login() async {
      formNotifier.setLoading(true);
      final res = await authMethod.signInUser(
        email: formState.email,
        password: formState.password,
      );
      formNotifier.setLoading(false);
      if (!context.mounted) return;
      if (res == 'success') {
        context.go('/home');
        CustomSnackbar.show(
          context,
          message: 'SignIn Successful.',
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
                    onChange: (value) =>
                        formNotifier.updateUserEmail(value),
                    icon: Icons.email_outlined,
                    labelText: 'Enter Email',
                    errortext: formState.emailError,
                  ),
                  const SizedBox(height: 8),
                  CustomTextfield(
                    obscureText: formState.isPasswordHidden,
                    onChange: (value) => formNotifier
                        .updateUserPassword(value),
                    icon: Icons.lock_outlined,
                    labelText: 'Enter Password',
                    errortext: formState.passwordError,
                    suffixIcon: SuffixIconButton(
                      notifier: formNotifier,
                      authState: formState,
                    ),
                  ),
                  const SizedBox(height: 3),
                  RememberMe(value: false, onTab: () {}),
                  const SizedBox(height: 10),
                  formState.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor:
                                Colors.blueAccent,
                          ),
                        )
                      : CustomElevatedButton(
                          text: 'Login',
                          onTab: formState.isFormValid
                              ? login
                              : null,
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
