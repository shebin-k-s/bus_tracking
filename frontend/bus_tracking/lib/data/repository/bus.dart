import 'package:bus_tracking/data/source/bus/bus_api_service.dart';
import 'package:bus_tracking/domain/repository/bus/bus.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';

class BusRepositoryImpl extends BusRepository {
  @override
  Future<Either> fetchBuses() {
    return sl<BusApiService>().fetchBuses();
  }
}
