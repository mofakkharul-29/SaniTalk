import 'package:flutter_riverpod/legacy.dart';

class PageIndexNotifier extends StateNotifier<int> {
  PageIndexNotifier() : super(0);

  void setPage(int index) => state = index;
}

final currentPageNotifierProvider =
    StateNotifierProvider<PageIndexNotifier, int>(
      (ref) => PageIndexNotifier(),
    );
