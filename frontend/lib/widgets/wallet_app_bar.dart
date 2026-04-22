import 'package:flutter/material.dart';
import 'package:frontend/models/wallet.dart';

/// App bar that displays the wallet name and provides navigation back functionality.
class WalletAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Wallet wallet;

    const WalletAppBar({ super.key, required this.wallet });

    @override
  Widget build(BuildContext context) {
        return AppBar(
            leading: const BackButton(
                color: Color.fromARGB(255, 0, 0, 0),
      ),
        title: Text(
            wallet.label,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
        backgroundColor: const Color.fromARGB(255, 110, 146, 232),
            centerTitle: true,
    );
    }

    @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}