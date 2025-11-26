import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sani_talk/core/router/router_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(
      RouterConfiguration.routerProvider,
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SaniTalk',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      routerConfig: router,
      // home: const RegisterScreen(),
      // home: const LoginScreen(),
      // home: const SplashScreen(),
      // home: const OnboardingScreen(),
    );
  }
}
