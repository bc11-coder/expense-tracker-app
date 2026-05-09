import 'package:flutter/material.dart';
import 'package:frontend/controllers/wallet_items_controller.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/utils/app_gradients.dart';
import 'package:frontend/utils/item_date_utils.dart';
import 'package:frontend/widgets/wallet_app_bar.dart';
import 'package:frontend/widgets/wallet_card_total.dart';
import 'package:frontend/widgets/wallet_date_section.dart';
import 'package:frontend/widgets/add_item_button.dart';
import 'package:frontend/widgets/wallet_value_chart.dart';

/// Screen that displays the details of a single wallet.
///
/// @author Batuhan Can
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key, required this.wallet});

  final Wallet wallet;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late final WalletItemsController controller;

  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    controller = WalletItemsController(widget.wallet);

    _scrollController.addListener(() {
      final show = _scrollController.offset > 20;
      if (show != _showScrollToTop) {
        setState(() {
          _showScrollToTop = show;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupedItems = ItemDateUtils.groupByDate(controller.items);
    final sortedDates = ItemDateUtils.sortedDates(controller.items);

    return Scaffold(
      appBar: WalletAppBar(wallet: widget.wallet),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: WalletScreenGradients.mainVertical,
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: WalletCardTotal(
                  totalValue: widget.wallet.totalValue,
                ),
              ),
              SliverToBoxAdapter(
                child: WalletValueChart(
                  items: controller.items,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 22),
              ),

              /// Grouped ItemList
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, dateIndex) {
                    final date = sortedDates[dateIndex];
                    final itemsForDate = groupedItems[date]!;

                    return WalletDateSection(
                      date: date,
                      items: itemsForDate,
                      onDelete: (item) {
                        setState(() {
                          controller.removeItem(item);
                        });
                      },
                    );
                  },
                  childCount: sortedDates.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _showScrollToTop ? 1 : 0,
            child: _showScrollToTop
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FloatingActionButton(
                      heroTag: "scrollToTop",
                      mini: true,
                      backgroundColor:
                          Colors.grey.withAlpha(180),
                      onPressed: _scrollToTop,
                      child: const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          AddItemButton(
            onAdd: (label, value, date) {
              setState(() {
                controller.addItem(label, value, date);
              });
            },
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}