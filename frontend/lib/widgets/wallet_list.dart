import 'package:flutter/material.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/screens/wallet_screen.dart';
import 'package:intl/intl.dart';

class WalletList extends StatelessWidget {
  final List<Wallet> wallets;
  final void Function(int) onDelete;
  final currencyFormatter = NumberFormat.currency(locale: 'de_DE', symbol: '€');

  WalletList({super.key, required this.wallets, required this.onDelete});

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),

          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WalletScreen(wallet: wallet),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: const Color.fromARGB(248, 255, 211, 170),
              elevation: 4,
              shadowColor: const Color.fromARGB(255, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: const Color.fromARGB(255, 215, 75, 0),
                  width: 1.8,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 70,

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          wallet.label,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          currencyFormatter.format(wallet.totalValue),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 215, 75, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
