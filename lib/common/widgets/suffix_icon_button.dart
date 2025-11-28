import 'package:flutter/material.dart';
import 'package:sani_talk/features/auth/model/auth_model.dart';
import 'package:sani_talk/features/auth/provider/auth_provider.dart';

class SuffixIconButton extends StatelessWidget {
  final AuthStateNotifier notifier;
  final AuthFormModelState authState;
  const SuffixIconButton({
    super.key,
    required this.notifier,
    required this.authState,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: notifier.togglePasswordVisibility,
      icon: Icon(
        authState.isPasswordHidden
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
      ),
    );
    ;
  }
}
