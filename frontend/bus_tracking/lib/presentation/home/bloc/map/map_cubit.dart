import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bus_tracking/common/helpers/map_icon.dart';
import 'package:bus_tracking/core/configs/assets/app_images.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this.busStops) : super(MapLoadingState());

  final List<Stop> busStops;
  late GoogleMapController _mapController;

  void initialize() async {
    try {
      final source = busStops.first.location.coordinates;
      final destination = busStops.last.location.coordinates;

      final sourceLoc = LatLng(source[1], source[0]);
      final destLoc = LatLng(destination[1], destination[0]);

      final markers = await _createMarkers();
      final polylineCoordinates = await _getPolyPoints(sourceLoc, destLoc);

      emit(MapLoadedState(
        currentBusPosition: sourceLoc,
        markers: markers,
        polylineCoordinates: polylineCoordinates,
      ));
    } catch (e) {
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
    }
  }

  Future<Set<Marker>> _createMarkers() async {
    final Set<Marker> markers = {};
    final Uint8List markerIcon =
        await getBytesFromAsset(AppImages.busStop, 100);

    for (var stop in busStops) {
      final coordinates = stop.location.coordinates;
      markers.add(
        Marker(
          markerId: MarkerId(stop.name),
          position: LatLng(coordinates[1], coordinates[0]),
          infoWindow: InfoWindow(title: stop.name),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ),
      );
    }
    return markers;
  }

  Future<List<LatLng>> _getPolyPoints(LatLng sourceLoc, LatLng destLoc) async {
    PolylinePoints polylinePoints = PolylinePoints();

    List<PolylineWayPoint> waypoints = busStops
        .sublist(1, busStops.length - 1)
        .map((stop) => PolylineWayPoint(
              location:
                  "${stop.location.coordinates[1]},${stop.location.coordinates[0]}",
              stopOver: true,
            ))
        .toList();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyCoEDgDwEhSkLs_bhWmPzErJa7imkZ6EiA",
      request: PolylineRequest(
        origin: PointLatLng(sourceLoc.latitude, sourceLoc.longitude),
        destination: PointLatLng(destLoc.latitude, destLoc.longitude),
        wayPoints: waypoints,
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      return [];
    }
  }

  void updateBusPosition(LatLng busPosition) async {
    if (state is MapLoadedState) {
      final currentState = state as MapLoadedState;

      final Uint8List busIcon =
          await getBytesFromAsset(AppImages.busLocator, 100);
      final updatedMarkers = Set<Marker>.from(currentState.markers)
        ..removeWhere((marker) => marker.markerId.value == "bus")
        ..add(
          Marker(
            markerId: const MarkerId("bus"),
            position: busPosition,
            icon: BitmapDescriptor.fromBytes(busIcon),
            infoWindow: const InfoWindow(title: "Bus"),
          ),
        );

      emit(
        MapLoadedState(
          currentBusPosition: busPosition,
          polylineCoordinates: currentState.polylineCoordinates,
          markers: updatedMarkers,
        ),
      );


      _mapController.animateCamera(CameraUpdate.newLatLng(busPosition));
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      updateBusPosition(busPosition);
    }
  }

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }
}
