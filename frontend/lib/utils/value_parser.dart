/// Utility for parsing and validating numeric input values with locale support.
class ValueParser {
  static double parse(String input, {required bool isNegative}) {
    final cleaned = input.replaceAll('.', '').replaceAll(',', '.');

    double value = double.parse(cleaned);

    return isNegative ? -value : value;
  }

  static bool isValid(String input) {
    final cleaned = input.replaceAll('.', '').replaceAll(',', '.');

    return double.tryParse(cleaned) != null;
  }

  static double? tryParseOptional(String input) {
    if (input.isEmpty) return null;

    final cleaned = input.replaceAll('.', '').replaceAll(',', '.');

    return double.tryParse(cleaned);
  }
}
