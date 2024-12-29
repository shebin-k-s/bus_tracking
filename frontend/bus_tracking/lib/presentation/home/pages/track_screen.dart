import 'dart:math' as math;
import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/helpers/time.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/domain/entities/bus/bus_location.dart';
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
            _buildHeaderCard(),
            const SizedBox(height: 20),
            _buildRouteStops(context),
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: () {},
              title: "View on Map",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bus Number',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    bus.busNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    bus.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.person, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Driver: ${bus.driverName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Phone: ${bus.driverNumber}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = math.cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * math.asin(math.sqrt(a));
  }

  BusLocationEntity _findBusPosition() {
    double busLat = 10.660416589396057;
    double busLng = 76.73209332097137;

    for (int i = 0; i < bus.routes.stops.length - 1; i++) {
      var currentStop = bus.routes.stops[i];
      var nextStop = bus.routes.stops[i + 1];

      double d1 = _calculateDistance(
          busLat,
          busLng,
          currentStop.location.coordinates[1],
          currentStop.location.coordinates[0]);
      double d2 = _calculateDistance(
        busLat,
        busLng,
        nextStop.location.coordinates[1],
        nextStop.location.coordinates[0],
      );
      double segmentLength = _calculateDistance(
        currentStop.location.coordinates[1],
        currentStop.location.coordinates[0],
        nextStop.location.coordinates[1],
        nextStop.location.coordinates[0],
      );

      if (d1 + d2 < segmentLength * 1.2) {
        double progress = d1 / segmentLength;
        return BusLocationEntity(
          index: i,
          progress: progress.clamp(0.0, 1.0),
        );
      }
    }

    double minDist = double.infinity;
    int nearestIndex = 0;

    for (int i = 0; i < bus.routes.stops.length; i++) {
      var stop = bus.routes.stops[i];
      double dist = _calculateDistance(busLat, busLng,
          stop.location.coordinates[1], stop.location.coordinates[0]);

      if (dist < minDist) {
        minDist = dist;
        nearestIndex = i;
      }
    }
    return BusLocationEntity(
      index: nearestIndex,
      progress: 0.0,
    );
  }

  Widget _buildRouteStops(BuildContext context) {
    var busPosition = _findBusPosition();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Route Stops',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bus.routes.stops.length,
                    itemBuilder: (context, index) {
                      final stop = bus.routes.stops[index];
                      final isLast = index == bus.routes.stops.length - 1;
                      String arrivalTime;

                      if (index == 0) {
                        arrivalTime = convertToISTAndAddTime(
                          DateTime.parse(bus.startTime),
                          0,
                        );
                      } else {
                        int totalDuration = 0;
                        for (int i = 0; i < index; i++) {
                          totalDuration +=
                              bus.routes.stops[i].durationToNextStop;
                        }
                        arrivalTime = convertToISTAndAddTime(
                          DateTime.parse(bus.startTime),
                          totalDuration,
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                arrivalTime,
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      if (!isLast)
                                        Container(
                                          width: 4,
                                          height: 80,
                                          color: context.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stop.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!isLast)
                                Text(
                                  "${(stop.distanceToNextStop / 1000).toStringAsFixed(2)} km",
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 90 * busPosition.index + 90 * busPosition.progress + 20,
            left: 65,
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
