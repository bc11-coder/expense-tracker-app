import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/widgets/item_list.dart';
import 'package:frontend/widgets/section_title.dart';
import 'package:frontend/models/item.dart';

/// Widget that groups and displays wallet items for a specific date.
class WalletDateSection extends StatelessWidget {
  final DateTime date;
  final List<Item> items;
  final Function(Item) onDelete;

  const WalletDateSection({
    super.key,
    required this.date,
    required this.items,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: DateFormat('dd.MM.yyyy').format(date)),
          ItemList(items: items, onDelete: onDelete),
        ],
      ),
    );
  }
}
