import 'package:frontend/models/item.dart';
import 'package:frontend/models/wallet.dart';

/// Controller that manages wallet items and provides grouping and sorting logic by date.
class WalletItemsController {
  final Wallet wallet;

  WalletItemsController(this.wallet);

  void addItem(String label, double value, DateTime date) {
    wallet.addItem(Item(label: label, value: value, date: date));
  }

  void removeItem(Item item) {
    wallet.removeItem(item);
  }

  List<Item> get items => wallet.items;
}