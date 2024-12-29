import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/domain/usecases/bus/bus.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'bus_state.dart';

class BusCubit extends Cubit<BusState> {
  BusCubit() : super(BusLoading());

  void fetchBuses() async {
    log("message");
    emit(BusLoading());
    Either result = await sl<FetchBusUseCase>().call();

    result.fold(
      (error) {
        log(error);
      },
      (data) {
        emit(
          BusLoaded(buses: data),
        );
      },
    );
  }
}
