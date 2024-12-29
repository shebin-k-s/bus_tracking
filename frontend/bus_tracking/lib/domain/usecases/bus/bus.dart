import 'package:bus_tracking/core/usecase/usecase.dart';
import 'package:bus_tracking/domain/repository/bus/bus.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';

class FetchBusUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) {
    return sl<BusRepository>().fetchBuses();
  }
}
