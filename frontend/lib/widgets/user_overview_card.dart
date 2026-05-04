import 'package:flutter/material.dart';
import 'package:frontend/utils/app_gradients.dart';
import 'package:frontend/utils/app_texts.dart';
import 'package:frontend/widgets/total_balance_text.dart';

/// Widget that displays an overview card with a welcome message and total balance of the user.
class UserOverviewCard extends StatelessWidget {
  final double totalBalance;

  const UserOverviewCard({super.key, required this.totalBalance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: UserOverviewCardGradients.userOverviewCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppTexts.welcome,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                AppTexts.subtitle,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 16),

              TotalBalanceText(amount: totalBalance),
            ],
          ),
        ),
      ),
    );
  }
}