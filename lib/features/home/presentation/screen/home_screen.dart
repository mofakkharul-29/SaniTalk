import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sani_talk/features/home/provider/bottom_nav_index.dart';

class HomeScreen extends ConsumerWidget {
  final StatefulNavigationShell? navigationShell;
  const HomeScreen({super.key, this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(indexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        currentIndex: currentIndex,
        onTap: (value) {
          ref
              .read(indexProvider.notifier)
              .changeIndex(value);
        },
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(
              currentIndex == 0
                  ? Icons.chat
                  : Icons.chat_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Users',
            icon: Icon(
              currentIndex == 1
                  ? Icons.people_alt
                  : Icons.people_alt_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              currentIndex == 2
                  ? Icons.person
                  : Icons.person_outline,
            ),
          ),
        ],
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
}
