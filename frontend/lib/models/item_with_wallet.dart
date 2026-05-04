import 'package:frontend/models/item.dart';

/// Data wrapper combining an item with its associated wallet label.
class ItemWithWallet {
  final Item item;
  final String walletLabel;

  ItemWithWallet({
    required this.item,
    required this.walletLabel,
  });
}