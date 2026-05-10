import 'package:flutter/material.dart';
import 'package:frontend/controllers/wallet_items_controller.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/utils/app_gradients.dart';
import 'package:frontend/utils/item_date_utils.dart';
import 'package:frontend/widgets/wallet_card_total.dart';
import 'package:frontend/widgets/wallet_date_section.dart';
import 'package:frontend/widgets/wallet_value_chart.dart';

/// Body of the WalletScreen containing gradient and scrollable content.
///
/// @author Batuhan Can
class WalletBody extends StatelessWidget {
  const WalletBody({
    super.key,
    required this.wallet,
    required this.controller,
    required this.scrollController,
    required this.onDelete,
  });

  final Wallet wallet;
  final WalletItemsController controller;
  final ScrollController scrollController;
  final void Function(dynamic item) onDelete;

  @override
  Widget build(BuildContext context) {
    final groupedItems = ItemDateUtils.groupByDate(controller.items);
    final sortedDates = ItemDateUtils.sortedDates(controller.items);

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: WalletScreenGradients.mainVertical,
          ),
        ),
        CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: WalletCardTotal(totalValue: wallet.totalValue),
            ),
            SliverToBoxAdapter(
              child: WalletValueChart(items: controller.items),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, dateIndex) {
                  final date = sortedDates[dateIndex];
                  final itemsForDate = groupedItems[date]!;

                  return WalletDateSection(
                    date: date,
                    items: itemsForDate,
                    onDelete: onDelete,
                  );
                },
                childCount: sortedDates.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ],
    );
  }
}