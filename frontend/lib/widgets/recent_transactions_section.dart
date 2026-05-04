import 'package:flutter/material.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/widgets/section_title.dart';
import 'package:frontend/widgets/show_all_button.dart';
import 'package:frontend/widgets/item_history_list.dart';

/// Section that shows recent transactions with expand/collapse functionality.
class RecentTransactionsSection extends StatelessWidget {
  final List<Wallet> wallets;
  final bool expanded;
  final VoidCallback onToggle;

  const RecentTransactionsSection({
    super.key,
    required this.wallets,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitle(title: "Recent Transactions:"),
            ShowAllButton(
              label: expanded ? "Show less" : "Show all",
              onPressed: onToggle,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: ItemHistoryList(
            wallets: wallets,
            expanded: expanded,
          ),
        ),
      ],
    );
  }
}