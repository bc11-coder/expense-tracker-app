import 'package:flutter/material.dart';
import 'package:frontend/controllers/wallet_items_controller.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/widgets/wallet_app_bar.dart';
import 'package:frontend/widgets/wallet_card_total.dart';
import 'package:frontend/widgets/wallet_date_section.dart';
import 'package:frontend/widgets/add_item_button.dart';

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

  @override
  void initState() {
    super.initState();
    controller = WalletItemsController(widget.wallet);
  }

  @override
  Widget build(BuildContext context) {
    final groupedItems = controller.groupedItems;
    final sortedDates = controller.sortedDates;

    return Scaffold(
      appBar: WalletAppBar(wallet: widget.wallet),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 110, 146, 232),
                  Color.fromARGB(255, 53, 79, 136),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              WalletCardTotal(totalValue: widget.wallet.totalValue),
              const SizedBox(height: 22),

              /// Grouped ItemList
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: sortedDates.length,
                  itemBuilder: (context, dateIndex) {
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
                ),
              ),
              const SizedBox(height: 22),
            ],
          ),
        ],
      ),
      floatingActionButton: AddItemButton(
        onAdd: (label, value, date) {
          setState(() {
            controller.addItem(label, value, date);

          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
