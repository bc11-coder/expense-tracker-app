import 'package:flutter/material.dart';

/// Defines all gradients used on the home screen.
class HomeScreenGradients {
  static const mainHorizontal = LinearGradient(
    colors: [
      Color.fromARGB(255, 14, 30, 71),
      Color.fromARGB(255, 7, 36, 111),
      Color.fromARGB(255, 14, 30, 71),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

/// Defines all gradients used on the wallet screen.
class WalletScreenGradients {
  static const mainVertical = LinearGradient(
    colors: [
      Color.fromARGB(255, 110, 146, 232),
      Color.fromARGB(255, 7, 36, 111),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Gradient definitions for wallet cards.
class WalletCardGradients {
  static const walletCard = LinearGradient(
    colors: [
      Color.fromARGB(255, 53, 79, 136),
      Color.fromARGB(255, 91, 125, 204),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Gradient definitions for total balance cards inside wallet screen.
class WalletCardTotalGradients {
  static const walletCardTotal = LinearGradient(
    colors: [
      Color.fromARGB(255, 53, 79, 136),
      Color.fromARGB(255, 91, 125, 204),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Gradient definitions for the user overview card.
class UserOverviewCardGradients {
  static const userOverviewCard = LinearGradient(
    colors: [
      Color.fromARGB(255, 53, 79, 136),
      Color.fromARGB(255, 91, 125, 204),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
