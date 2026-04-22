import 'package:flutter/material.dart';
import 'package:frontend/widgets/add_item_dialog.dart';

/// Floating action button that opens a dialog to add a new wallet item.
class AddItemButton extends StatelessWidget {
  final Function(String, double, DateTime) onAdd;

  const AddItemButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 215, 75, 0),
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddItemDialog(onAdd: onAdd);
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
