import 'package:frontend/models/wallet.dart';
import 'package:frontend/models/item_with_wallet.dart';

/// Controller that prepares and filters item history data for the UI.
class ItemHistoryListController {
  final List<Wallet> wallets;

  ItemHistoryListController(this.wallets);

  List<ItemWithWallet> _collectItems() {
    final List<ItemWithWallet> all = [];

    for (final wallet in wallets) {
      for (final item in wallet.items) {
        all.add(
          ItemWithWallet(
            item: item,
            walletLabel: wallet.label,
          ),
        );
      }
    }

    // newest first
    all.sort((a, b) => b.item.date.compareTo(a.item.date));

    return all;
  }

  List<ItemWithWallet> topItems(int count) {
    final items = _collectItems();
    return items.length <= count ? items : items.sublist(0, count);
  }

  List<ItemWithWallet> remainingItems(int offset) {
    final items = _collectItems();
    return items.length <= offset ? [] : items.sublist(offset);
  }
}