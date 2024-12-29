import 'package:bus_tracking/core/navigation_keys/navigation_keys.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/presentation/home/pages/home_screen.dart';
import 'package:bus_tracking/presentation/home/pages/track_screen.dart';
import 'package:bus_tracking/presentation/profile/pages/profile_screen.dart';
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
              return const ProfileScreen();
            }
            if (settings.name == "/track") {
              final args = settings.arguments as Map;
              return TrackScreen(
                bus: args['bus'] as BusEntity,
              );
            }
            return const HomeScreen();
          },
        );
      },
    );
  }
}
