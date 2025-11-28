import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sani_talk/core/constant/appstartup/app_start_up.dart';
import 'package:sani_talk/core/theme/color_pallate.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoAnimation;
  late final Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _logoAnimation = Tween<double>(begin: 0, end: 1)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutBack,
          ),
        );

    _textAnimation = Tween<double>(begin: 0, end: 1)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.5,
              1.0,
              curve: Curves.easeIn,
            ),
          ),
        );
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      ref
          .read(splashStateNotifierProvider.notifier)
          .setSplashComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double logoMaxSize = screenWidth * 0.4;
    final double logoMinSize = screenWidth * 0.3;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final logoSize =
                logoMinSize +
                (logoMaxSize - logoMinSize) *
                    _logoAnimation.value;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: logoSize,
                  width: logoSize,
                ),
                const SizedBox(height: 15),
                // App Name
                Opacity(
                  opacity: _textAnimation.value,
                  child: Text(
                    'SaniTalk',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
