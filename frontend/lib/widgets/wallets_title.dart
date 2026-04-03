import 'package:flutter/material.dart';
import 'package:frontend/widgets/section_title.dart';

/// Widget that displays the title for the wallets section, including the count of wallets.
class WalletsTitle extends StatelessWidget {
  final int count;
  const WalletsTitle({required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return SectionTitle(title: "My Wallets ($count):");
  }
}
