import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';
import 'package:sani_talk/features/home/presentation/widgets/custom_bottom_nav.dart';

class HomeScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: shadowColor,
        title: Text(
          _getTitle(),
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: navigationShell,
      bottomNavigationBar: CustomBottomNav(
        navigationShell: navigationShell,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const Text('Home Screen'),
      //         CustomElevatedButton(
      //           onTab: () async {
      //             final userActions = ref.read(
      //               authMethodProvider,
      //             );
      //             final authNotifier = ref.read(
      //               authStateNotifierProvider.notifier,
      //             );
      //             final result = await userActions.logOut();
      //             if (!context.mounted) return;
      //             CustomSnackbar.show(
      //               message: 'log out $result',
      //               context,
      //             );
      //             if (result == 'success') {
      //               authNotifier.resetState();
      //             }
      //             if (result != 'success' &&
      //                 context.mounted) {
      //               CustomSnackbar.show(
      //                 message: result,
      //                 context,
      //               );
      //             }
      //           },
      //           text: 'Sign Out',
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  String _getTitle() {
    return switch (navigationShell.currentIndex) {
      0 => 'Chat',
      1 => 'Users',
      2 => 'Profile',
      _ => 'Home',
    };
  }
}
