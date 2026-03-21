import 'package:flutter/material.dart';
import 'package:frontend/models/item.dart';

class ItemList extends StatelessWidget {
  final List<Item> items;
  final void Function(int) onDelete;

  const ItemList({super.key, required this.items, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Dismissible(
          key: ValueKey(item),
          direction: DismissDirection.endToStart,

          onDismissed: (direction) {
            onDelete(index);
          },

          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),

          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: const Color.fromARGB(255, 215, 75, 0),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Expanded(
                    child: Text(
                      "${item.value}€",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
