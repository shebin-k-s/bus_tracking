import 'package:bus_tracking/data/models/auth/auth_req_params.dart';
import 'package:bus_tracking/data/source/auth/auth_api_service.dart';
import 'package:bus_tracking/domain/repository/auth/auth.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(AuthReqParams signupReq) {
    return sl<AuthApiService>().signup(signupReq);
  }

  @override
  Future<Either> signin(AuthReqParams signinReq) {
    return sl<AuthApiService>().signin(signinReq);
  }
}
