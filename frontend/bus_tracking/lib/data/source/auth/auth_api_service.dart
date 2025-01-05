import 'dart:developer';

import 'package:bus_tracking/core/constants/api_urls.dart';
import 'package:bus_tracking/core/network/dio_client.dart';
import 'package:bus_tracking/data/models/auth/auth_req_params.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthApiService {
  Future<Either> signup(AuthReqParams signupReq);
  Future<Either> signin(AuthReqParams signinReq);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(AuthReqParams signupReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.signup,
        data: signupReq.toMap(),
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "Network error");
    }
  }

  @override
  Future<Either> signin(AuthReqParams signinReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.signin,
        data: signinReq.toMap(),
      );

      if (response.data['token'] != null) {
        final sharedPref = await SharedPreferences.getInstance();

        sharedPref.setString("TOKEN", response.data['token']);
        sharedPref.setString("FULLNAME", response.data['fullName']);
        sharedPref.setString("EMAIL", response.data['email']);

        return Right(response.data['message']);
      }
      return Left(response.data['message']);
    } on DioException catch (e) {
      log(e.toString());
      return Left(e.response?.data['message'] ?? "Network error");
    }
  }
}
