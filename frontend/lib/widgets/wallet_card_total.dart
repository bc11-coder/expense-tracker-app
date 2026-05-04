import 'package:flutter/material.dart';
import 'package:frontend/utils/app_gradients.dart';
import 'package:frontend/utils/currency_utils.dart';

/// Card widget that displays the total balance of a wallet.
class WalletCardTotal extends StatelessWidget {
  const WalletCardTotal({super.key, required this.totalValue});

  final double totalValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 12,
      shadowColor: const Color.fromARGB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: const Color.fromARGB(255, 215, 75, 0),
          width: 3.0,
        ),
      ),
      color: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: WalletCardTotalGradients.walletCardTotal,
          borderRadius: BorderRadius.all(Radius.circular(18)),
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
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              Text(
                CurrencyUtils.format(totalValue),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}