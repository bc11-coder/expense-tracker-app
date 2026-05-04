import 'item.dart';

/// Data model representing a wallet with a label and a list of items.
/// The total value is calculated dynamically based on all items.
class Wallet {
  final String label;
  final List<Item> items;

  Wallet({
    required this.label,
    List<Item>? items,
  }) : items = items ?? [];

  /// Adds a new item to the wallet.
  void addItem(Item item) {
    items.add(item);
  }

  /// Removes an item from the wallet.  
  void removeItem(Item item) {
    items.remove(item);
  }

  /// Calculates the total value of all items in this wallet.
  double get totalValue {
    return items.fold(0.0, (sum, item) => sum + item.value);
  }
}