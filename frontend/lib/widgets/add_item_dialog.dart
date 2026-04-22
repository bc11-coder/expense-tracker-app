import 'package:flutter/material.dart';
import 'package:frontend/utils/date_picker_utils.dart';
import 'package:frontend/utils/value_parser.dart';
import 'package:frontend/widgets/value_switch_button.dart';
import 'package:frontend/utils/date_format_utils.dart';
import 'package:frontend/utils/validators.dart';

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
  late final TextEditingController _dateController;

  bool _isNegative = true;

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
      text: DateFormatUtils.format(_selectedDate),
    );
  }

  @override
  void dispose() {
    labelController.dispose();
    valueController.dispose();
    _dateController.dispose();
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
              validator: (value) =>
                  Validators.required(value, 'Please enter a label'),
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
                    validator: (value) =>
                        Validators.number(value, 'Please enter only a number'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Date Picker that opens a calendar when the user clicks on the text field.
            TextFormField(
              readOnly: true,
              onTap: () async {
                final picked = await DatePickerUtils.pickDate(
                  context,
                  _selectedDate,
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                    _dateController.text = DateFormatUtils.format(
                      _selectedDate,
                    );
                  });
                }
              },
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: "Date",
                suffixIcon: Icon(Icons.calendar_today),
              ),
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

              final value = ValueParser.parse(
                valueController.text,
                isNegative: _isNegative,
              );

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
