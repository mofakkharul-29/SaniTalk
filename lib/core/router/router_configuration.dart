import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sani_talk/core/constant/widget/route_name.dart';
import 'package:sani_talk/core/router/router_notifier.dart';
import 'package:sani_talk/features/auth/presentation/screens/login_screen.dart';
import 'package:sani_talk/features/auth/presentation/screens/register_screen.dart';
import 'package:sani_talk/features/home/presentation/screen/home_screen.dart';
import 'package:sani_talk/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:sani_talk/features/splash/presentation/screen/splash_screen.dart';

class RouterConfiguration {
  static final routerProvider = Provider<GoRouter>((ref) {
    // final bool startUpStatus = ref.watch(
    //   appStartUpNotifierProvider,
    // ); // false
    // final bool isSplashLoading = ref.watch(
    //   splashStateNotifierProvider,
    // ); // false
    // final refreshNotifier = ref.watch(
    //   authRefreshNotifierProvider,
    // );
    final routerNotifier = ref.watch(
      routerNotifierProvider,
    );

    return GoRouter(
      initialLocation: '/splash',
      debugLogDiagnostics: true,
      // refreshListenable: refreshNotifier,
      refreshListenable: routerNotifier,

      // redirect: (context, state) {
      //   final path = state.uri.path;
      //   final User? user =
      //       FirebaseAuth.instance.currentUser;

      //   if (isSplashLoading) {
      //     return null;
      //   }

      //   if (startUpStatus) {
      //     if (path != '/onboarding') {
      //       return '/onboarding';
      //     }
      //   }

      //   if (!startUpStatus) {
      //     final authPaths = ['/login', '/register'];
      //     if (user == null) {
      //       // User is logged out: They can be on /login or /register, but nowhere else.
      //       if (!authPaths.contains(path)) {
      //         return '/login'; // Force them to login screen if they try to access /home, etc.
      //       }
      //     }
      //     if (user != null && authPaths.contains(path)) {
      //       return '/home'; // Logged in: Force them away from login/register
      //     }
      //   }
      //   return null;
      // },
      redirect: (context, state) {
        final path = state.uri.path;

        // Access state directly from our Notifier getters
        final isSplash = routerNotifier.isSplashLoading;
        final isFirstLaunch = routerNotifier.isFirstLaunch;
        final user = routerNotifier.currentUser;

        // --- Redirect Logic ---

        // 1. If Splash is loading, stay here.
        if (isSplash) {
          return null;
        }

        // 2. Splash is done. If it's the first launch, go to Onboarding.
        if (isFirstLaunch) {
          if (path != '/onboarding') {
            return '/onboarding';
          }
          // If we are already on onboarding, return null to allow it.
          return null;
        }

        // 3. Not first launch. Check Auth.
        final authPaths = ['/login', '/register'];

        if (user == null) {
          // User is logged out.
          // If they are trying to go somewhere other than login/register, force Login.
          if (!authPaths.contains(path)) {
            return '/login';
          }
        } else {
          // User is logged in.
          // If they are on login/register/splash/onboarding, send to Home.
          if (authPaths.contains(path) ||
              path == '/splash' ||
              path == '/onboarding') {
            return '/home';
          }
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
        GoRoute(
          path: '/home',
          name: homeScreenRouteName,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  });
}
