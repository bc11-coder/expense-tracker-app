import 'package:flutter/material.dart';
import 'package:frontend/controllers/item_history_list_controller.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/widgets/item_history_card.dart';

/// Builds a list of recent item history entries based on controller logic.
class ItemHistoryList extends StatelessWidget {
  final List<Wallet> wallets;
  final bool expanded;

  const ItemHistoryList({
    super.key,
    required this.wallets,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    final controller = ItemHistoryListController(wallets);

    final top3 = controller.topItems(3);
    final remaining =
        expanded ? controller.remainingItems(3) : [];

    return Column(
      children: [
        ...top3.map((entry) => ItemHistoryCard(entry: entry)),
        ...remaining.map((entry) => ItemHistoryCard(entry: entry)),
      ],
    );
  }
}