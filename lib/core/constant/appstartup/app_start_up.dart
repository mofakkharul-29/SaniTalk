import 'package:flutter/material.dart';
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
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}

final appStartUpNotifierProvider =
    StateNotifierProvider<AppStartUpNotifier, bool>(
      (ref) => AppStartUpNotifier(),
    );
