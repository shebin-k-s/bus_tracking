import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusPositionEntity {
  int index;
  double progress;
  LatLng coordinates;

  BusPositionEntity({
    required this.index,
    required this.progress,
    required this.coordinates,
  });
}
