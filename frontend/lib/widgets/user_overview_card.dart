import 'package:flutter/material.dart';

/// Widget that displays an overview card with a welcome message and total balance of the user.
class UserOverviewCard extends StatelessWidget {
  const UserOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: const Color.fromARGB(255, 255, 230, 205),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome, Max Mustermann!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "To your personal expense tracker",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                "Total balance: 1.500,00€",
                style: TextStyle(
                  color: Color.fromARGB(255, 215, 75, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
