import 'package:flutter_riverpod/legacy.dart';
import 'package:sani_talk/features/auth/model/auth_model.dart';

class AuthStateNotifier
    extends StateNotifier<AuthFormModelState> {
  AuthStateNotifier() : super(AuthFormModelState());

  void togglePasswordVisibility() {
    state = state.copyWith(
      isPasswordHidden: !state.isPasswordHidden,
    );
  }

  void updateUserName(String name) {
    String? nameError;

    if (name.isNotEmpty && name.length < 6) {
      nameError = 'username must be at least 6 characters';
    }
    state = state.copyWith(
      name: name,
      nameError: nameError,
    );
  }

  void updateUserEmail(String email) {
    String? emailError;

    if (email.isNotEmpty &&
        !RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(email)) {
      emailError = 'Enter a valid email';
    }

    state = state.copyWith(
      email: email,
      emailError: emailError,
    );
  }

  void updateUserPassword(String password) {
    String? passwordError;

    if (password.isNotEmpty && password.length < 6) {
      passwordError =
          'Password must be at least 6 characters';
    }
    state = state.copyWith(
      password: password,
      passwordError: passwordError,
    );
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void resetState() {
    state = AuthFormModelState();
  }
}

final authStateNotifierProvider =
    StateNotifierProvider<
      AuthStateNotifier,
      AuthFormModelState
    >((ref) => AuthStateNotifier());
