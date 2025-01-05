import 'package:bus_tracking/core/navigation_keys/navigation_keys.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/presentation/home/bloc/bus/bus_cubit.dart';
import 'package:bus_tracking/presentation/home/pages/home_screen.dart';
import 'package:bus_tracking/presentation/home/pages/track_screen.dart';
import 'package:bus_tracking/presentation/ticket/pages/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            if (settings.name == "/track") {
              final args = settings.arguments as Map;
              final bus = args['bus'] as BusEntity;
              return BlocBuilder<BusCubit, BusState>(
                builder: (context, state) {
                  return TrackScreen(
                    bus: state is BusLoaded
                        ? state.buses.firstWhere((b) => b.id == bus.id)
                        : bus,
                  );
                },
              );
            }
            if (settings.name == "/ticket") {
              return  TicketScreen();
            }
            return const HomeScreen();
          },
        );
      },
    );
  }
}
