import 'package:flutter/material.dart';
import 'package:frontend/widgets/add_item_button.dart';
import 'package:frontend/widgets/scroll_to_top_button.dart';

/// Floating action button section of the WalletScreen.
///
/// Combines the scroll-to-top button and the add-item button.
///
/// @author Batuhan Can
class WalletFabSection extends StatelessWidget {
  const WalletFabSection({
    super.key,
    required this.showScrollToTop,
    required this.onScrollToTop,
    required this.onAddItem,
  });

  final bool showScrollToTop;
  final VoidCallback onScrollToTop;
  final void Function(String label, double value, DateTime date) onAddItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScrollToTopButton(
          visible: showScrollToTop,
          onPressed: onScrollToTop,
        ),
        AddItemButton(
          onAdd: onAddItem,
        ),
      ],
    );
  }
}