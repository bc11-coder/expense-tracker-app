import 'package:frontend/models/item.dart';
import 'package:frontend/utils/wallet_chart_range.dart';

class ChartPoint {
  final double x;
  final double y;
  final DateTime date;

  ChartPoint({
    required this.x,
    required this.y,
    required this.date,
  });
}

class WalletChartDataUtils {
  static List<ChartPoint> generateChartPoints(
    List<Item> items,
    WalletChartRange range,
    DateTime focus,
  ) {
    if (items.isEmpty) return [];

    items.sort((a, b) => a.date.compareTo(b.date));

    switch (range) {
      case WalletChartRange.week:
        final start =
            focus.subtract(Duration(days: focus.weekday - 1));
        return _generateDaily(items, start, 7);

      case WalletChartRange.month:
        final start = DateTime(focus.year, focus.month, 1);
        final end = DateTime(focus.year, focus.month + 1, 0);
        return _generateWeeklyMonth(items, start, end);

      case WalletChartRange.year:
        final start = DateTime(focus.year, 1, 1);
        return _generateMonthly(items, start, 12);
    }
  }

  static List<ChartPoint> _generateDaily(
      List<Item> items, DateTime start, int days) {
    double cumulative = _balanceBefore(items, start);
    final points = <ChartPoint>[];

    for (int i = 0; i < days; i++) {
      final day = start.add(Duration(days: i));

      for (final item in items) {
        if (_sameDay(item.date, day)) {
          cumulative += item.value;
        }
      }

      points.add(
        ChartPoint(x: i.toDouble(), y: cumulative, date: day),
      );
    }

    return points;
  }

  static List<ChartPoint> _generateWeeklyMonth(
      List<Item> items, DateTime start, DateTime end) {
    double cumulative = _balanceBefore(items, start);
    final points = <ChartPoint>[];

    DateTime cursor = start;
    int index = 0;

    while (!cursor.isAfter(end)) {
      final weekEnd = cursor.add(const Duration(days: 6));

      for (final item in items) {
        if (!item.date.isBefore(cursor) &&
            !item.date.isAfter(weekEnd)) {
          cumulative += item.value;
        }
      }

      points.add(
        ChartPoint(
          x: index.toDouble(),
          y: cumulative,
          date: cursor,
        ),
      );

      cursor = cursor.add(const Duration(days: 7));
      index++;
    }

    return points;
  }

  static List<ChartPoint> _generateMonthly(
      List<Item> items, DateTime start, int months) {
    double cumulative = _balanceBefore(items, start);
    final points = <ChartPoint>[];

    for (int i = 0; i < months; i++) {
      final monthStart =
          DateTime(start.year, start.month + i, 1);
      final monthEnd =
          DateTime(start.year, start.month + i + 1, 0);

      for (final item in items) {
        if (!item.date.isBefore(monthStart) &&
            !item.date.isAfter(monthEnd)) {
          cumulative += item.value;
        }
      }

      points.add(
        ChartPoint(
          x: i.toDouble(),
          y: cumulative,
          date: monthStart,
        ),
      );
    }

    return points;
  }

  static double _balanceBefore(List<Item> items, DateTime date) {
    double sum = 0;

    for (final item in items) {
      if (item.date.isBefore(date)) {
        sum += item.value;
      }
    }

    return sum;
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year &&
      a.month == b.month &&
      a.day == b.day;

  static int isoWeek(DateTime date) {
    final thursday =
        date.add(Duration(days: 4 - date.weekday));
    final firstJan = DateTime(thursday.year, 1, 1);
    final diff = thursday.difference(firstJan).inDays;
    return (diff / 7).floor() + 1;
  }
}