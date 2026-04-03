import 'package:flutter/material.dart';
import 'package:frontend/widgets/add_wallet_dialog.dart';

/// Button that opens the AddWalletDialog.
/// The parent must provide the onAdd callback.
class AddWalletButton extends StatelessWidget {
  final void Function(String label, double totalValue) onAdd;

  const AddWalletButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor: const Color.fromARGB(255, 215, 75, 0),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddWalletDialog(onAdd: onAdd);
            },
          );
        },
        child: const Text("Add Wallet"),
      ),
    );
  }
}
