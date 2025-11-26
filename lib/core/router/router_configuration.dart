import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sani_talk/core/constant/appstartup/app_start_up.dart';
import 'package:sani_talk/core/constant/widget/route_name.dart';
import 'package:sani_talk/features/auth/presentation/screens/login_screen.dart';
import 'package:sani_talk/features/auth/presentation/screens/register_screen.dart';
import 'package:sani_talk/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:sani_talk/features/splash/presentation/screen/splash_screen.dart';

class RouterConfiguration {
  static final routerProvider = Provider<GoRouter>((ref) {
    final User? user = FirebaseAuth.instance.currentUser;

    final bool startUpStatus = ref.watch(
      appStartUpNotifierProvider,
    );
    return GoRouter(
      initialLocation: '/splash',
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final path = state.uri.path;

        if (startUpStatus == true &&
            path != '/onboarding') {
          return '/onboarding';
        }

        if (startUpStatus == false &&
            (user == null && path != '/register')) {
          return '/register';
        }

        if (startUpStatus == false &&
            (user != null && path != '/login')) {
          return '/login';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/splash',
          name: splashScreenRouteName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          name: onboardingScreenRouteName,
          builder: (context, state) =>
              const OnboardingScreen(),
        ),
        GoRoute(
          path: '/register',
          name: registerScreenRouteName,
          builder: (context, state) =>
              const RegisterScreen(),
        ),
        GoRoute(
          path: '/login',
          name: loginScreenRouteName,
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    );
  });
}
