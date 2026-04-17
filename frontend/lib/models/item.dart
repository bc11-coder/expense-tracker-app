/// Data model representing an item, with a label and a value.
class Item {
  final String label;
  final double value;
  final DateTime date;

  Item({required this.label, required this.value, required this.date});
}
