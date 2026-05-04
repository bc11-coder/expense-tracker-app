import 'package:frontend/models/item.dart';
import 'package:frontend/models/wallet.dart';

/// Factory class responsible for creating wallets with optional initial balance.
class WalletFactory {
  static Wallet create(String label, double initialBalance) {
    final wallet = Wallet(label: label);

    if (initialBalance != 0) {
      wallet.addItem(
        Item(
          label: "Initial Balance",
          value: initialBalance,
          date: DateTime.now(),
        ),
      );
    }

    return wallet;
  }
}