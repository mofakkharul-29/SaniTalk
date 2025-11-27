import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStartUpNotifier extends StateNotifier<bool> {
  AppStartUpNotifier() : super(true) {
    _init();
  }

  Future<void> _init() async {
    final pref = await SharedPreferences.getInstance();
    state = pref.getBool('isFirstLaunch') ?? true;
  }

  Future<void> setFirstLaunchedStatus(bool value) async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();
    try {
      pref.setBool('isFirstLaunch', value);
      state = value;
    } catch (e) {
      throw e.toString();
    }
  }
}

final appStartUpNotifierProvider =
    StateNotifierProvider<AppStartUpNotifier, bool>(
      (ref) => AppStartUpNotifier(),
    );

class SplashStateNotifier extends StateNotifier<bool> {
  SplashStateNotifier() : super(true);

  void setSplashComplete() {
    state = false;
  }
}

final splashStateNotifierProvider =
    StateNotifierProvider<SplashStateNotifier, bool>(
      (ref) => SplashStateNotifier(),
    );
