import 'package:flutter/material.dart';
import 'package:frontend/models/item.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/utils/currency_utils.dart';
import 'package:intl/intl.dart';

/// Shows transactions from all wallets.
/// Always shows top 3 items.
/// Expands to show all when [expanded] is true.
class AllItemsList extends StatelessWidget {
  final List<Wallet> wallets;
  final bool expanded;

  const AllItemsList({
    super.key,
    required this.wallets,
    required this.expanded,
  });

  List<_ItemWithWallet> _collectItems() {
    final List<_ItemWithWallet> all = [];

    for (final wallet in wallets) {
      for (final item in wallet.items) {
        all.add(_ItemWithWallet(item: item, walletLabel: wallet.label));
      }
    }

    // newest first
    all.sort((a, b) => b.item.date.compareTo(a.item.date));

    return all;
  }

  @override
  Widget build(BuildContext context) {
    final items = _collectItems();
    final dateFormat = DateFormat('dd.MM.yyyy');

    final top3 = items.length <= 3 ? items : items.sublist(0, 3);
    final remaining = expanded && items.length > 3
        ? items.sublist(3)
        : <_ItemWithWallet>[];

    Widget buildCard(_ItemWithWallet entry) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: SizedBox(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.item.label,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${entry.walletLabel} • ${dateFormat.format(entry.item.date)}",
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Text(
                  CurrencyUtils.formatSigned(entry.item.value),
                  style: TextStyle(
                    fontSize: 16, // etwas größer
                    fontWeight: FontWeight.bold,
                    color: entry.item.value < 0 ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: [...top3.map(buildCard), ...remaining.map(buildCard)],
    );
  }
}

class _ItemWithWallet {
  final Item item;
  final String walletLabel;

  _ItemWithWallet({required this.item, required this.walletLabel});
}
