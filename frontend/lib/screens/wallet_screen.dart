import 'package:flutter/material.dart';
import 'package:frontend/models/item.dart';
import 'package:frontend/widgets/add_item_dialog.dart';
import 'package:frontend/widgets/item_list.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<Item> items = [];

  void addItem(String label, double value) {
    setState(() {
      items.add(Item(label: label, value: value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
        title: const Text(
          "TrackXpense",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 233, 233, 233),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: const Color.fromARGB(255, 255, 204, 176),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 100,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 215, 75, 0),
                        ),
                      ),
                    ),
                    Text(
                      "2,800.00€",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 215, 75, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 22),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ItemList(
                items: items,
                onDelete: (int index) {
                  setState(() {
                    items.removeAt(index);
                  });
                },
              ),
            ),
          ),

          SizedBox(height: 22),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 215, 75, 0),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddItemDialog(onAdd: addItem);
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
