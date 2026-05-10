import 'package:flutter/material.dart';

/// A floating button that appears when [visible] is true
/// and triggers [onPressed] when tapped.
///
/// @author Batuhan Can
class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({
    super.key,
    required this.visible,
    required this.onPressed,
  });

  final bool visible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: visible ? 1 : 0,
      child: visible
          ? Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FloatingActionButton(
                heroTag: "scrollToTop",
                mini: true,
                backgroundColor: Colors.grey.withAlpha(180),
                onPressed: onPressed,
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}