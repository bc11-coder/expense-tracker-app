import 'package:frontend/models/item.dart';

/// Controller that manages wallet items and provides grouping and sorting logic by date.
class WalletItemsController {
  final List<Item> items = [];

  void addItem(String label, double value, DateTime date) {
    items.add(Item(label: label, value: value, date: date));
  }

  void removeItem(Item item) {
    items.remove(item);
  }

  DateTime _normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  Map<DateTime, List<Item>> get groupedItems {
    final Map<DateTime, List<Item>> map = {};

    for (final item in items) {
      final dateOnly = _normalize(item.date);

      map.putIfAbsent(dateOnly, () => []);
      map[dateOnly]!.insert(0, item);
    }

    return map;
  }

  List<DateTime> get sortedDates {
    final dates = items.map((e) => _normalize(e.date)).toSet().toList();
    dates.sort((a, b) => b.compareTo(a));
    return dates;
  }
}
