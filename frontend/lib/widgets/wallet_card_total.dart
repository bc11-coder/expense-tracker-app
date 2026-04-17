import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletCardTotal extends StatelessWidget {
  WalletCardTotal({super.key, required this.totalValue});

  final String totalValue;
  final currencyFormatter = NumberFormat.currency(locale: 'de_DE', symbol: '€');

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: const Color.fromARGB(248, 255, 211, 170),
      elevation: 8,
      shadowColor: const Color.fromARGB(255, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: const Color.fromARGB(255, 215, 75, 0),
          width: 3.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 215, 75, 0),
                  ),
                ),
              ),
              Text(
                currencyFormatter.format(double.parse(totalValue)),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 215, 75, 0),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
