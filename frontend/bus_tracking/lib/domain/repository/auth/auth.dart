import 'package:bus_tracking/data/models/auth/auth_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {

  Future<Either> signup(AuthReqParams signupReq);
  Future<Either> signin(AuthReqParams signinReq);
}