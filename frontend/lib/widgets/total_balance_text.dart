import 'package:flutter/material.dart';
import 'package:frontend/utils/currency_utils.dart';

/// Styled text widget that displays the formatted total balance.
class TotalBalanceText extends StatelessWidget {
  final double amount;

  const TotalBalanceText({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final text = "Total balance: ${CurrencyUtils.format(amount)}";

    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = const Color.fromARGB(255, 215, 75, 0),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 204, 183),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}