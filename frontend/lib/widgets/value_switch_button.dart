import 'package:flutter/material.dart';

class ValueSwitchButton extends StatefulWidget {
  final String offLabel;
  final String onLabel;
  final ValueChanged<bool>? onChanged;

  const ValueSwitchButton({
    super.key,
    this.offLabel = '-',
    this.onLabel = '+',
    this.onChanged,
  });

  @override
  _ValueSwitchButtonState createState() => _ValueSwitchButtonState();
}

class _ValueSwitchButtonState extends State<ValueSwitchButton> {
  bool _isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
        ),
        ToggleButtons(
          borderRadius: BorderRadius.circular(8),
          isSelected: [_isFirst, !_isFirst],
          onPressed: (index) {
            setState(() {
              _isFirst = (index == 0);
              widget.onChanged?.call(_isFirst);
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.offLabel,
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.onLabel,
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              ),),
            ),
          ],
        ),
      ],
    );
  }
}

