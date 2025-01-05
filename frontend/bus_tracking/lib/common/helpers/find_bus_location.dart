import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/domain/entities/bus/bus_position.dart';
import 'dart:math' as math;

import 'package:google_maps_flutter/google_maps_flutter.dart';

double calculateDistance(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  var p = 0.017453292519943295;
  var c = math.cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * math.asin(math.sqrt(a));
}

BusPositionEntity findBusPosition(
    List<Stop> stops, double busLat, double busLng) {
  for (int i = 0; i < stops.length - 1; i++) {
    var currentStop = stops[i];
    var nextStop = stops[i + 1];

    double d1 = calculateDistance(
        busLat,
        busLng,
        currentStop.location.coordinates[1],
        currentStop.location.coordinates[0]);
    double d2 = calculateDistance(
      busLat,
      busLng,
      nextStop.location.coordinates[1],
      nextStop.location.coordinates[0],
    );
    double segmentLength = calculateDistance(
      currentStop.location.coordinates[1],
      currentStop.location.coordinates[0],
      nextStop.location.coordinates[1],
      nextStop.location.coordinates[0],
    );

    if (d1 + d2 < segmentLength * 1.2) {
      double progress = d1 / segmentLength;

      return BusPositionEntity(
          index: i,
          progress: progress.clamp(0.0, 1.0),
          coordinates: LatLng(busLat, busLng));
    }
  }

  double minDist = double.infinity;
  int nearestIndex = 0;

  for (int i = 0; i < stops.length; i++) {
    var stop = stops[i];
    double dist = calculateDistance(busLat, busLng,
        stop.location.coordinates[1], stop.location.coordinates[0]);

    if (dist < minDist) {
      minDist = dist;
      nearestIndex = i;
    }
  }
  return BusPositionEntity(
      index: nearestIndex, progress: 0.0, coordinates: LatLng(busLat, busLng));
}
