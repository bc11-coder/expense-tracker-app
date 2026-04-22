
/// Collection of validation helpers for form input fields.
class Validators {
  static String? required(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? number(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }

    final cleaned = value.replaceAll('.', '').replaceAll(',', '.');

    if (double.tryParse(cleaned) == null) {
      return message;
    }

    return null;
  }
}