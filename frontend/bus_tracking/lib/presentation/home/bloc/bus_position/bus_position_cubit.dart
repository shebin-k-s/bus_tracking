import 'package:bloc/bloc.dart';
import 'package:bus_tracking/domain/entities/bus/bus_position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'bus_position_state.dart';

class BusPositionCubit extends Cubit<UpdatedBusPosition> {
  BusPositionCubit()
      : super(UpdatedBusPosition(
            busPosition: BusPositionEntity(
                index: 0, progress: 0, coordinates: const LatLng(0, 0))));

  void updatePosition(BusPositionEntity busPosition) {
    emit(
      UpdatedBusPosition(busPosition: busPosition),
    );
  }

  void reset() {
    UpdatedBusPosition(
      busPosition: BusPositionEntity(
        index: 0,
        progress: 0,
        coordinates: const LatLng(0, 0),
      ),
    );
  }
}
