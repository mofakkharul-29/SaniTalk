import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';
import 'package:sani_talk/features/onboarding/presentation/widgets/custom_page_builder.dart';
import 'package:sani_talk/features/onboarding/provider/page_index_provider.dart';
import 'package:sani_talk/features/onboarding/provider/pages_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(
      currentPageNotifierProvider,
    );
    final pages = ref.watch(pageProvider);
    final isLastPage = currentIndex == pages.length - 1;

    final statusBarHeight = MediaQuery.of(
      context,
    ).padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: const CustomPageBuilder(),
          ),
          if (isLastPage)
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.arrow_forward,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius:
                          BorderRadiusGeometry.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                  ),
                  label: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
