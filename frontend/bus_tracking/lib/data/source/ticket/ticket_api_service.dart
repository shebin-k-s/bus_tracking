import 'package:bus_tracking/core/constants/api_urls.dart';
import 'package:bus_tracking/core/network/dio_client.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class TicketApiService {
  Future<Either> fetchTicket();
}

class TicketApiServiceImpl extends TicketApiService {
  @override
  Future<Either> fetchTicket() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.fetchTicket,
      );
      print(response);
      if(response.data['ticketCount'] != null){

      return Right(response.data['ticketCount']);
      }
      return Left(response.data['message']??"Error");
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "Network error");
    }
  }
}
