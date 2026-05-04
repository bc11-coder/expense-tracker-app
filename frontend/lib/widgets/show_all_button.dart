import 'package:flutter/material.dart';

/// Reusable button to toggle between collapsed and expanded list views.
class ShowAllButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const ShowAllButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          foregroundColor: const Color.fromARGB(255, 255, 249, 243),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
