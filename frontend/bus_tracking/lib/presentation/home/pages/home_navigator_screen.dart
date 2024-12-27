import 'package:bus_tracking/core/navigation_keys/navigation_keys.dart';
import 'package:bus_tracking/presentation/home/pages/home_screen.dart';
import 'package:bus_tracking/presentation/ticket/pages/ticket_screen.dart';
import 'package:flutter/material.dart';

class HomeNavigatorScreen extends StatelessWidget {
  const HomeNavigatorScreen({
    super.key,
    required this.navigatorIndex,
  });

  final int navigatorIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: GlobalNavigatorKeys.navigatorKeys[navigatorIndex],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            if (settings.name == "/ticket") {
              return const TicketScreen();
            }
            return const HomeScreen();
          },
        );
      },
    );
  }
}
