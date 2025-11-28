import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sani_talk/core/constant/appstartup/app_start_up.dart';
import 'package:sani_talk/core/router/router_refresh_listenable.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(
      authStateChangesProvider,
      (_, __) => notifyListeners(),
    );
    // Listen to Splash Changes
    _ref.listen(
      splashStateNotifierProvider,
      (_, __) => notifyListeners(),
    );
    // Listen to Onboarding/Startup Changes
    _ref.listen(
      appStartUpNotifierProvider,
      (_, __) => notifyListeners(),
    );
  }

  // Helper getters to clean up the redirect logic
  bool get isSplashLoading =>
      _ref.read(splashStateNotifierProvider);
  bool get isFirstLaunch =>
      _ref.read(appStartUpNotifierProvider);
  User? get currentUser =>
      FirebaseAuth.instance.currentUser;
}

final routerNotifierProvider = Provider<RouterNotifier>((
  ref,
) {
  return RouterNotifier(ref);
});
