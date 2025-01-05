import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/presentation/home/pages/map_screen.dart';
import 'package:bus_tracking/presentation/home/widgets/bus_header_card.dart';
import 'package:bus_tracking/presentation/home/widgets/bus_route_details.dart';
import 'package:flutter/material.dart';

class TrackScreen extends StatelessWidget {
  final BusEntity bus;

  const TrackScreen({
    super.key,
    required this.bus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bus Details',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BusHeaderCard(bus: bus),
            const SizedBox(height: 20),
            BusRouteDetails(
              bus: bus,
            ),
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: () {
                AppNavigator.push(
                  context,
                  MapScreen(
                    busStops: bus.routes.stops,
                  ),
                );
              },
              title: "View on Map",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
