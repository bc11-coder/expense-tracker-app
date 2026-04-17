import 'package:flutter/material.dart';
import 'package:frontend/widgets/value_switch_button.dart';
import 'package:intl/intl.dart';

/// A dialog widget which gets opened by using the AddItemButton.
/// It allows the user to add a new item with a label, value and date.
class AddItemDialog extends StatefulWidget {
  final Function(String, double, DateTime) onAdd;

  const AddItemDialog({super.key, required this.onAdd});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController labelController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NumberFormat numberFormat = NumberFormat.decimalPattern('de_DE');

  bool _isNegative = true;

  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    labelController.dispose();
    valueController.dispose();
    super.dispose();
  }

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
                ValueSwitchButton(
                  onChanged: (value) {
                    setState(() {
                      _isNegative = value;
                    });
                  },
                ),
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

            const SizedBox(height: 12),

            //Date Picker that opens a calendar when the user clicks on the text field.
            TextFormField(
              readOnly: true,
              onTap: () => _pickDate(context),
              controller: TextEditingController(
                text: DateFormat('dd.MM.yyyy').format(_selectedDate),
              ),
              decoration: const InputDecoration(
                labelText: "Date",
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            // -----------------------------------------------------
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
              final rawValue = valueController.text
                  .replaceAll('.', '')
                  .replaceAll(',', '.');

              double value = double.parse(rawValue);

              if (_isNegative) {
                value = -value;
              }

              widget.onAdd(label, value, _selectedDate);
              Navigator.pop(context);
            }
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
