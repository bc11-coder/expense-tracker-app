import 'package:flutter/material.dart';
import 'package:frontend/models/item.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/widgets/add_wallet_button.dart';
import 'package:frontend/widgets/section_title.dart';
import 'package:frontend/widgets/show_all_button.dart';
import 'package:frontend/widgets/user_overview_card.dart';
import 'package:frontend/widgets/wallet_list.dart';
import 'package:frontend/widgets/wallets_title.dart';
import 'package:frontend/widgets/all_items_list.dart';

/// The main screen of the app, showing an overview of the user's wallets and recent transactions.
/// The user can add and delete new wallets and view details of existing ones.
///
/// @author Batuhan Can
/// @Date 2026-04-03
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Wallet> wallets = [];

  bool showAllTransactions = false;

  // Adds a new wallet to the list of wallets with a label and total value.
  void addWallet(String label, double initialBalance) {
    setState(() {
      final wallet = Wallet(label: label);

      if (initialBalance != 0) {
        wallet.addItem(
          Item(
            label: "Initial Balance",
            value: initialBalance,
            date: DateTime.now(),
          ),
        );
      }

      wallets.add(wallet);
    });
  }

  /// Collects ALL items from all wallets (global transaction list)
  List<Item> get allItems {
    final List<Item> items = [];

    for (final wallet in wallets) {
      items.addAll(wallet.items);
    }

    items.sort((a, b) => b.date.compareTo(a.date)); // newest first
    return items;
  }

  List<Item> get previewItems {
    final items = allItems;
    return items.length <= 3 ? items : items.sublist(0, 3);
  }

  List<Item> get sortedItems {
    final items = allItems;
    return items; // already sorted newest first
  }

  List<Item> get top3Items {
    final items = sortedItems;
    return items.length <= 3 ? items : items.sublist(0, 3);
  }

  List<Item> get remainingItems {
    final items = sortedItems;
    return items.length <= 3 ? [] : items.sublist(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Monetrack_AppLogo.PNG', height: 60),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 53, 79, 136),
                Color.fromARGB(255, 9, 35, 101),
                Color.fromARGB(255, 53, 79, 136),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 53, 79, 136),
                  Color.fromARGB(255, 9, 35, 101),
                  Color.fromARGB(255, 53, 79, 136),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),

          ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UserOverviewCard(),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WalletsTitle(count: wallets.length),
                      AddWalletButton(onAdd: addWallet),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: WalletList(
                      wallets: wallets,
                      onDelete: (int index) {
                        setState(() {
                          wallets.removeAt(index);
                        });
                      },
                      onReturn: () {
                        setState(() {});
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionTitle(title: "Recent Transactions:"),
                      ShowAllButton(
                        label: showAllTransactions ? "Show less" : "Show all",
                        onPressed: () {
                          setState(() {
                            showAllTransactions = !showAllTransactions;
                          });
                        },
                      ),
                    ],
                  ),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: AllItemsList(
                        wallets: wallets,
                        expanded: showAllTransactions,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
