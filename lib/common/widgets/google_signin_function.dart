import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sani_talk/common/widgets/custom_snackbar.dart';
import 'package:sani_talk/features/auth/services/auth_method.dart';

class GoogleSigninFunction {
  static Future onGoogleTap({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final auth = ref.read(authMethodProvider);
    final result = await auth.signInWithGoogle();
    if (!context.mounted) return;
    if (result == 'success') {
      debugPrint('Google login successful!');
      CustomSnackbar.show(
        context,
        message: 'Google login successful!',
      );
    } else {
      CustomSnackbar.show(context, message: result);
    }
  }
}
