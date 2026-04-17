import 'package:flutter/material.dart';
import 'package:frontend/models/item.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/widgets/add_item_dialog.dart';
import 'package:frontend/widgets/item_list.dart';
import 'package:frontend/widgets/section_title.dart';
import 'package:frontend/widgets/wallet_card_total.dart';
import 'package:intl/intl.dart';

/// Screen that displays the details of a single wallet.
/// 
/// @author Batuhan Can
class WalletScreen extends StatefulWidget {
  WalletScreen({super.key, required this.wallet});
  final Wallet wallet;

  final currencyFormatter = NumberFormat.currency(locale: 'de_DE', symbol: '€');

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<Item> items = [];

  void addItem(String label, double value, DateTime date) {
    setState(() {
      items.add(Item(label: label, value: value, date: date));
    });
  }

  Map<DateTime, List<Item>> get groupedItems {
    final Map<DateTime, List<Item>> map = {};

    for (final item in items) {
      final dateOnly = DateTime(item.date.year, item.date.month, item.date.day);

      if (!map.containsKey(dateOnly)) {
        map[dateOnly] = [];
      }
      // New Items appear on top of the list for each date
      map[dateOnly]!.insert(0, item);
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    final sortedDates = groupedItems.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // newest first

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: const Color.fromARGB(255, 0, 0, 0),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Text(
          widget.wallet.label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 91, 125, 204),



        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                Color.fromARGB(255, 91, 125, 204),
                Color.fromARGB(255, 53, 79, 136),

                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              WalletCardTotal(totalValue: widget.wallet.totalValue.toString()),
              const SizedBox(height: 22),

              /// Grouped ItemList
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: sortedDates.length,
                  itemBuilder: (context, dateIndex) {
                    final date = sortedDates[dateIndex];
                    final itemsForDate = groupedItems[date]!;

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(
                            title: DateFormat('dd.MM.yyyy').format(date),
                          ),

                          ItemList(
                            items: itemsForDate,
                            onDelete: (int index) {
                              setState(() {
                                items.remove(itemsForDate[index]);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 215, 75, 0),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddItemDialog(
                onAdd: (String label, double value, DateTime date) {
                  addItem(label, value, date);
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
