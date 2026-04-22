import 'package:flutter/material.dart';
import 'package:frontend/models/item.dart';
import 'package:frontend/utils/currency_utils.dart';

/// Widget that displays a list of items, with swipe-to-delete functionality.
class ItemList extends StatelessWidget {
  final List<Item> items;
  final void Function(Item) onDelete;

  ItemList({super.key, required this.items, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Dismissible(
          key: ValueKey(item),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => onDelete(item),
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),

          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_bag,
                    color: Color.fromARGB(255, 215, 75, 0),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      item.label,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),

                  Expanded(child: Container()),

                  Text(
                    CurrencyUtils.formatSigned(item.value),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: item.value < 0 ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
