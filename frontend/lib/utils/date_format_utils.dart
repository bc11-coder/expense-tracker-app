import 'package:intl/intl.dart';

/// Utility class for formatting DateTime objects into readable date strings.
class DateFormatUtils {
  static final _formatter = DateFormat('dd.MM.yyyy');

  static String format(DateTime date) {
    return _formatter.format(date);
  }
}
