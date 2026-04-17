import 'package:flutter/material.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/widgets/add_wallet_button.dart';
import 'package:frontend/widgets/section_title.dart';
import 'package:frontend/widgets/show_all_button.dart';
import 'package:frontend/widgets/user_overview_card.dart';
import 'package:frontend/widgets/wallet_list.dart';
import 'package:frontend/widgets/wallets_title.dart';

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

  // Adds a new wallet to the list of wallets with a label and total value.
  void addWallet(String label, double totalValue) {
    setState(() {
      wallets.add(Wallet(label: label, totalValue: totalValue));
    });
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
                Color.fromARGB(255, 255, 224, 191),
                Color.fromARGB(255, 252, 153, 91),
                Color.fromARGB(255, 255, 224, 191),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          // Handles the background gradient of the screen.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                Color.fromARGB(255, 255, 224, 191),
                Color.fromARGB(255, 252, 153, 91),
                Color.fromARGB(255, 255, 224, 191),
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
                      // Displays the number of wallets the user has and a button to add new wallets.
                      WalletsTitle(count: wallets.length),
                      AddWalletButton(onAdd: addWallet),
                    ],
                  ),
                  // Displays the list of wallets the user has, allowing them to view details or delete them.
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: WalletList(
                      wallets: wallets,
                      onDelete: (int index) {
                        setState(() {
                          wallets.removeAt(index);
                        });
                      },
                    ),
                  ),
                  // Displays a section for recent transactions, with a button to show all transactions.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionTitle(title: "Recent Transactions:"),
                      ShowAllButton(),
                    ],
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
