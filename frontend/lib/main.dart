import 'package:flutter/material.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/screens/home_screen.dart';

void main() {
  runApp(MonetrackApp());
}
/// The main entry point of the application, which initializes and runs the MonetrackApp widget.
class MonetrackApp extends StatelessWidget {
  MonetrackApp({super.key});
  final Wallet wallet = Wallet(label: "Wallet", totalValue: 0.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monetrack',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
