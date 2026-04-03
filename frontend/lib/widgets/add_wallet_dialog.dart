import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A dialog widget which gets opened by using the AddWalletButton.
/// It allows the user to add a new wallet with a label and (optional) initial balance
class AddWalletDialog extends StatefulWidget {
  final Function(String, double) onAdd;

  const AddWalletDialog({super.key, required this.onAdd});

  @override
  State<AddWalletDialog> createState() => _AddWalletDialogState();
}

class _AddWalletDialogState extends State<AddWalletDialog> {
  final TextEditingController walletController = TextEditingController();
  final TextEditingController initialBalanceController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NumberFormat numberFormat = NumberFormat.decimalPattern('de_DE');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Wallet"),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: walletController,
              decoration: InputDecoration(labelText: "Wallet Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Wallet name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: initialBalanceController,
              decoration: InputDecoration(
                labelText: "Initial Balance (optional)",
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null; // optional field
                }

                final cleanedValue = value
                    .replaceAll('.', '')
                    .replaceAll(',', '.');

                if (double.tryParse(cleanedValue) == null) {
                  return 'Please enter a valid number';
                }

                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 215, 75, 0),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final label = walletController.text;

              double initialBalance = 0.0;

              if (initialBalanceController.text.isNotEmpty) {
                final cleanedValue = initialBalanceController.text
                    .replaceAll('.', '')
                    .replaceAll(',', '.');

                initialBalance = double.parse(cleanedValue);
              }
              widget.onAdd(label, initialBalance);

              Navigator.pop(context);
            }
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
