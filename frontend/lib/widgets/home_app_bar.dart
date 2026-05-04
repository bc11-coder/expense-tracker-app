import 'package:flutter/material.dart';
import 'package:frontend/utils/app_gradients.dart';

/// Custom AppBar with gradient background for the home screen.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/Monetrack_AppLogo.PNG',
        height: 60,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: HomeScreenGradients.mainHorizontal,
        ),
      ),
    );
  }
}