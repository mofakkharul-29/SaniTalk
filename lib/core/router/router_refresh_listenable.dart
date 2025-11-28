import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class StreamRefreshNotifier extends ChangeNotifier {
  // this will hold the connection between our StreamNotifier and firebase Stream
  final StreamSubscription _subscription;

  StreamRefreshNotifier(Stream<dynamic> stream)
    : _subscription = stream.listen((_) {}) {
    _subscription.onData((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final authRefreshNotifierProvider =
    Provider<StreamRefreshNotifier>((ref) {
      final notifier = StreamRefreshNotifier(
        FirebaseAuth.instance.authStateChanges(),
      );
      ref.onDispose(() {
        notifier.dispose();
      });
      return notifier;
    });

final authStateChangesProvider = StreamProvider<User?>((
  ref,
) {
  return FirebaseAuth.instance.authStateChanges();
});

final isAuthCheckCompleteProvider = StateProvider<bool>((
  ref,
) {
  final authStream = ref.watch(authStateChangesProvider);

  return authStream.maybeWhen(
    loading: () => false,
    orElse: () => true,
  );
});
