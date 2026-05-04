import 'package:flutter/material.dart';
import 'package:frontend/utils/app_gradients.dart';

/// Reusable gradient background container for main screens.
class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: HomeScreenGradients.mainHorizontal,
      ),
    );
  }
}