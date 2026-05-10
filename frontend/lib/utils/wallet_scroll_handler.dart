import 'package:flutter/material.dart';

/// Handles scroll behavior and scroll-to-top visibility logic
/// for the WalletScreen.
///
/// @author Batuhan Can
class WalletScrollHandler {
  WalletScrollHandler({required this.onVisibilityChanged}) {
    scrollController.addListener(_handleScroll);
  }

  final ScrollController scrollController = ScrollController();
  final ValueChanged<bool> onVisibilityChanged;

  bool _showScrollToTop = false;

  void _handleScroll() {
    final show = scrollController.offset > 20;
    if (show != _showScrollToTop) {
      _showScrollToTop = show;
      onVisibilityChanged(show);
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void dispose() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
  }
}