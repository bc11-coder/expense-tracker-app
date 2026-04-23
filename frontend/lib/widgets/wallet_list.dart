import 'package:flutter/material.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/screens/wallet_screen.dart';
import 'package:frontend/widgets/wallet_card.dart';
import 'package:intl/intl.dart';

/// Widget that displays a list of wallets, with swipe-to-delete functionality.
/// Tapping on a wallet opens the WalletScreen for that wallet.
class WalletList extends StatelessWidget {
  final List<Wallet> wallets;
  final void Function(int) onDelete;
  final currencyFormatter = NumberFormat.currency(locale: 'de_DE', symbol: '€');
  final VoidCallback onReturn;

  WalletList({
    super.key,
    required this.wallets,
    required this.onDelete,
    required this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(wallets.length, (index) {
        final wallet = wallets[index];

        return Dismissible(
          key: ValueKey(wallet),
          direction: DismissDirection.endToStart,

          onDismissed: (direction) {
            onDelete(index);
          },

          background: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.red,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),

          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WalletScreen(wallet: wallet),
                ),
              );

              onReturn(); // trigger rebuild
            },
            child: WalletCard(wallet: wallet),
          ),
        );
      }),
    );
  }
}
