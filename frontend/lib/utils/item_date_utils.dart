import 'package:frontend/models/item.dart';

/// Utility class for normalizing, grouping and sorting items by date.
class ItemDateUtils {
  static DateTime normalize(DateTime d) =>
      DateTime(d.year, d.month, d.day);

  static Map<DateTime, List<Item>> groupByDate(List<Item> items) {
    final Map<DateTime, List<Item>> map = {};

    for (final item in items) {
      final dateOnly = normalize(item.date);

      map.putIfAbsent(dateOnly, () => []);
      map[dateOnly]!.insert(0, item);
    }

    return map;
  }

  static List<DateTime> sortedDates(List<Item> items) {
    final dates =
        items.map((e) => normalize(e.date)).toSet().toList();

    dates.sort((a, b) => b.compareTo(a));
    return dates;
  }
}