import 'package:flutter/material.dart';

/// Helper class that wraps the native date picker dialog for consistent date selection.
class DatePickerUtils {
  static Future<DateTime?> pickDate(
    BuildContext context,
    DateTime initialDate,
  ) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }
}
