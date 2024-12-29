import 'package:bus_tracking/core/constants/api_urls.dart';
import 'package:bus_tracking/core/network/dio_client.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class BusApiService {
  Future<Either> fetchBuses();
}

class BusApiServiceImpl extends BusApiService {
  @override
  Future<Either> fetchBuses() async {
    try {
      var response = await sl<DioClient>().get(ApiUrls.fetchBus);

      if (response.data["buses"] != null) {
        List<dynamic> busesData = response.data["buses"];

        List<BusEntity> buses = busesData
            .map(
              (bus) => BusEntity.fromJson(bus),
            )
            .toList();

        return Right(buses);
      }
      return Left(response.data['message']);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "Network error");
    }
  }
}
