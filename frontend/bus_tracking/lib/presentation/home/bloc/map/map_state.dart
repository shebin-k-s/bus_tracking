part of 'map_cubit.dart';

abstract class MapState {}

class MapLoadingState extends MapState {}

class MapLoadedState extends MapState {
  final LatLng currentBusPosition;
  final List<LatLng> polylineCoordinates;
  final Set<Marker> markers;

  MapLoadedState({
    required this.currentBusPosition,
    required this.polylineCoordinates,
    required this.markers,
  });

  MapLoadedState copyWith({
    LatLng? currentBusPosition,
    List<LatLng>? polylineCoordinates,
    Set<Marker>? markers,
  }) {
    return MapLoadedState(
      currentBusPosition: currentBusPosition ?? this.currentBusPosition,
      polylineCoordinates: polylineCoordinates ?? this.polylineCoordinates,
      markers: markers ?? this.markers,
    );
  }
}

class MapErrorState extends MapState {}
