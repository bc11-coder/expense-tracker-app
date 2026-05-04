import 'package:frontend/factories/wallet_factory.dart';
import 'package:frontend/models/item.dart';
import 'package:frontend/models/wallet.dart';

/// Main controller for home screen logic including wallets and items.
class HomeScreenController {
  final List<Wallet> wallets;

  HomeScreenController(this.wallets);

  void addWallet(String label, double initialBalance) {
    wallets.add(WalletFactory.create(label, initialBalance));
  }

  List<Item> get allItems {
    final List<Item> items = [];
    for (final wallet in wallets) {
      items.addAll(wallet.items);
    }
    items.sort((a, b) => b.date.compareTo(a.date));
    return items;
  }

  List<Item> get top3Items {
    final items = allItems;
    return items.length <= 3 ? items : items.sublist(0, 3);
  }

  List<Item> get remainingItems {
    final items = allItems;
    return items.length <= 3 ? [] : items.sublist(3);
  }

  double get totalBalance {
    return wallets.fold(0.0, (sum, w) => sum + w.totalValue);
  }
}
