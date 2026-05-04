import 'package:flutter/material.dart';
import 'package:frontend/controllers/home_screen_controller.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/widgets/app_background.dart';
import 'package:frontend/widgets/home_app_bar.dart';
import 'package:frontend/widgets/recent_transactions_section.dart';
import 'package:frontend/widgets/user_overview_card.dart';
import 'package:frontend/widgets/wallets_section.dart';

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
  late HomeScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeScreenController(wallets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Stack(
        children: [
          const AppBackground(),
          ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  UserOverviewCard(totalBalance: controller.totalBalance),
                  const SizedBox(height: 16),

                  WalletsSection(
                    wallets: wallets,
                    controller: controller,
                    onStateChanged: () {
                      setState(() {});
                    },
                  ),

                  RecentTransactionsSection(
                    wallets: wallets,
                    expanded: showAllTransactions,
                    onToggle: () {
                      setState(() {
                        showAllTransactions = !showAllTransactions;
                      });
                    },
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
