import 'package:flutter/material.dart';
import 'package:frontend/controllers/home_screen_controller.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/widgets/add_wallet_button.dart';
import 'package:frontend/widgets/wallet_list.dart';
import 'package:frontend/widgets/wallets_title.dart';

/// Section widget that displays all wallets with title and add button.
class WalletsSection extends StatelessWidget {
  final List<Wallet> wallets;
  final HomeScreenController controller;
  final VoidCallback onStateChanged;

  const WalletsSection({
    super.key,
    required this.wallets,
    required this.controller,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WalletsTitle(count: wallets.length),
            AddWalletButton(
              onAdd: (label, initialBalance) {
                controller.addWallet(label, initialBalance);
                onStateChanged();
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: WalletList(
            wallets: wallets,
            onDelete: (int index) {
              wallets.removeAt(index);
              onStateChanged();
            },
            onReturn: onStateChanged,
          ),
        ),
      ],
    );
  }
}