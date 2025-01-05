import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DelayCalculator {
  static int calculateDelay(
    DateTime startTime,
    List<Stop> stops, 
    int currentStopIndex, 
    double progress, 
    LatLng currentPosition, 
  ) {
    int elapsedSeconds = DateTime.now().difference(startTime).inSeconds;

    int expectedSecondsToCurrentPosition = 0;

    for (int i = 0; i < currentStopIndex; i++) {
      expectedSecondsToCurrentPosition += stops[i].durationToNextStop;
    }

    if (currentStopIndex < stops.length - 1) {
      expectedSecondsToCurrentPosition +=
          (stops[currentStopIndex].durationToNextStop * progress).round();
    }

    int delay = elapsedSeconds - expectedSecondsToCurrentPosition;


    return delay;
  }
}
