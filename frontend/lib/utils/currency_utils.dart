import 'package:intl/intl.dart';

/// Utility class for formatting currency values into German Euro format.
class CurrencyUtils {
  static final _formatter = NumberFormat.currency(locale: 'de_DE', symbol: '€');

  static String format(double value) => _formatter.format(value);

  static String formatSigned(double value) {
    final formatted = _formatter.format(value);
    return value > 0 ? '+$formatted' : formatted;
  }
}
