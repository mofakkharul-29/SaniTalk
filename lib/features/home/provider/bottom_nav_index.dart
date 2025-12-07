import 'package:flutter_riverpod/legacy.dart';

class BottomNavIndexNotifier extends StateNotifier<int> {
  BottomNavIndexNotifier() : super(0);

  void changeIndex(int val) {
    state = val;
  }
}

final indexProvider = StateNotifierProvider(
  (ref) => BottomNavIndexNotifier(),
);
