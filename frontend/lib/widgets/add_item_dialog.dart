import 'package:flutter/material.dart';
import 'package:frontend/widgets/value_switch_button.dart';
import 'package:intl/intl.dart';

class AddItemDialog extends StatefulWidget {
  final Function(String, double) onAdd;

  const AddItemDialog({super.key, required this.onAdd});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController labelController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NumberFormat numberFormat = NumberFormat.decimalPattern('de_DE');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add item"),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: labelController,
              decoration: InputDecoration(labelText: "Label"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a label';
                }
                return null;
              },
            ),
            Row(
              children: [
                ValueSwitchButton(),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: valueController,
                    decoration: InputDecoration(labelText: "Value"),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      
                      final cleanedValue = value
                          .replaceAll('.', '')
                          .replaceAll(',', '.');

                      if (double.tryParse(cleanedValue) == null) {
                        return 'Please enter only a number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
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
              final label = labelController.text;
              final value = valueController.text
                  .replaceAll('.', '')
                  .replaceAll(',', '.');
              widget.onAdd(label, double.parse(value));
              Navigator.pop(context);
            }
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
