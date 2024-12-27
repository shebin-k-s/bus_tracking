import 'package:bus_tracking/core/usecase/usecase.dart';
import 'package:bus_tracking/data/models/auth/auth_req_params.dart';
import 'package:bus_tracking/domain/repository/auth/auth.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';

class SigninUseCase implements UseCase<Either, AuthReqParams> {
  @override
  Future<Either> call({AuthReqParams? param}) {
    return sl<AuthRepository>().signin(param!);
  }
}
