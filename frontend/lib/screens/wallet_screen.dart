import 'package:flutter/material.dart';
import 'package:frontend/controllers/wallet_items_controller.dart';
import 'package:frontend/models/wallet.dart';
import 'package:frontend/utils/wallet_scroll_handler.dart';
import 'package:frontend/widgets/wallet_app_bar.dart';
import 'package:frontend/widgets/wallet_body.dart';
import 'package:frontend/widgets/wallet_fab_section.dart';

/// Screen that displays the details of a single wallet.
///
/// @author Batuhan Can
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key, required this.wallet});

  final Wallet wallet;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late final WalletItemsController controller;
  late final WalletScrollHandler scrollHandler;

  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();

    controller = WalletItemsController(widget.wallet);

    scrollHandler = WalletScrollHandler(
      onVisibilityChanged: (show) {
        if (show != _showScrollToTop) {
          setState(() {
            _showScrollToTop = show;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    scrollHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletAppBar(wallet: widget.wallet),
      body: WalletBody(
        wallet: widget.wallet,
        controller: controller,
        scrollController: scrollHandler.scrollController,
        onDelete: (item) {
          setState(() {
            controller.removeItem(item);
          });
        },
      ),
      floatingActionButton: WalletFabSection(
        showScrollToTop: _showScrollToTop,
        onScrollToTop: scrollHandler.scrollToTop,
        onAddItem: (label, value, date) {
          setState(() {
            controller.addItem(label, value, date);
          });
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}