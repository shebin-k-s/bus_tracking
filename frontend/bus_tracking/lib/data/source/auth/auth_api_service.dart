import 'package:bus_tracking/core/network/dio_client.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';

abstract class AuthApiService {

  Future<Either> signup();
}


class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup() {

    try {
      sl<DioClient>().post(url)
    } catch (e) {
      
    }
   
  }

}