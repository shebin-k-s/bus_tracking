import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bus_tracking/common/helpers/delay_calculator.dart';
import 'package:bus_tracking/common/helpers/find_bus_location.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/domain/usecases/bus/bus.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'bus_state.dart';

class BusCubit extends Cubit<BusState> {
  BusCubit() : super(BusLoading());

  void fetchBuses() async {
    Either result = await sl<FetchBusUseCase>().call();

    result.fold(
      (error) async {
        log(error);
        await Future.delayed(
          const Duration(seconds: 5),
        );
        fetchBuses();
      },
      (data) {
        final List<BusEntity> buses = (data as List<BusEntity>).map((bus) {
          final busPosition = findBusPosition(
            bus.routes.stops,
            bus.currentLocation.coordinates[1],
            bus.currentLocation.coordinates[0],
          );
          final int delay = DelayCalculator.calculateDelay(
            DateTime.parse(bus.startTime),
            bus.routes.stops,
            busPosition.index,
            busPosition.progress,
            LatLng(
              bus.currentLocation.coordinates[1],
              bus.currentLocation.coordinates[0],
            ),
          );

          bus.routes.delayInSeconds = delay;
          return bus;
        }).toList();
        emit(
          BusLoaded(buses: buses),
        );
      },
    );
  }

  void updateStopDelaysAndBusLocation(
      String busId, int delay, LatLng location) {
    if (state is BusLoaded) {
      final currentState = state as BusLoaded;
      final buses = currentState.buses.map((bus) {
        if (bus.id == busId) {
          bus.routes.delayInSeconds = delay;
          bus.currentLocation = Location(
            coordinates: [
              location.longitude,
              location.latitude,
            ],
          );
        }
        return bus;
      }).toList();

      emit(BusLoaded(buses: buses));
    }
  }

  void reset() {
    BusLoading();
  }
}
