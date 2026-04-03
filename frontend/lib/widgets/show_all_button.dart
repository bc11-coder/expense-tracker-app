import 'package:flutter/material.dart';

/// Button that shows all existing items.
/// The parent must provide the onAdd callback.
class ShowAllButton extends StatelessWidget {
  const ShowAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          foregroundColor: const Color.fromARGB(255, 215, 75, 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: const Text("Show all"),
      ),
    );
  }
}
