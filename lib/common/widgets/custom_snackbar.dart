import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(
    BuildContext context,
    {
      required String message,
      Duration duration = const Duration(seconds: 3),
    }
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(14),
        ),
        duration: duration,
        ),
    );
  }
}