import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sani_talk/common/widgets/custom_elevated_button.dart';
import 'package:sani_talk/common/widgets/custom_snackbar.dart';
import 'package:sani_talk/features/auth/provider/auth_provider.dart';
import 'package:sani_talk/features/auth/services/auth_method.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  final userActions = ref.read(
                    authMethodProvider,
                  );
                  final authNotifier = ref.read(
                    authStateNotifierProvider.notifier,
                  );
                  final result = await userActions.logOut();
                  if (!context.mounted) return;
                  CustomSnackbar.show(
                    message: 'log out $result',
                    context,
                  );
                  if (result == 'success') {
                    authNotifier.resetState();
                  }
                  if (result != 'success' &&
                      context.mounted) {
                    CustomSnackbar.show(
                      message: result,
                      context,
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
