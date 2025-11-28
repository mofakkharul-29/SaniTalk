import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sani_talk/common/widgets/custom_elevated_button.dart';
import 'package:sani_talk/features/auth/services/auth_method.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userActions = ref.watch(authMethodProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Home Screen'),
              CustomElevatedButton(
                onTab: () async {
                  final result = await userActions.logOut();
                  if (result != 'success' &&
                      context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Logout failed: $result',
                        ),
                      ),
                    );
                  }
                },
                text: 'Sign Out',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
