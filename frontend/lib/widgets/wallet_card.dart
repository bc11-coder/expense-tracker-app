import 'package:flutter/material.dart';
import 'package:frontend/models/wallet.dart';
import 'package:intl/intl.dart';

class WalletCard extends StatelessWidget {
  WalletCard({super.key, required this.wallet});

  final Wallet wallet;
  final currencyFormatter =
      NumberFormat.currency(locale: 'de_DE', symbol: '€');

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 4,
      shadowColor: const Color.fromARGB(0, 119, 133, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: const Color.fromARGB(255, 215, 75, 0),
          width: 1.8,
        ),
      ),
      color: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 53, 79, 136),
              Color.fromARGB(255, 91, 125, 204),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: SizedBox(
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
                      color: const Color.fromARGB(255, 255, 255, 255),
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
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}