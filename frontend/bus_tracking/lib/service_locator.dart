import 'package:bus_tracking/core/network/dio_client.dart';
import 'package:bus_tracking/data/repository/auth.dart';
import 'package:bus_tracking/data/source/auth/auth_api_service.dart';
import 'package:bus_tracking/domain/repository/auth/auth.dart';
import 'package:bus_tracking/domain/usecases/auth/signin.dart';
import 'package:bus_tracking/domain/usecases/auth/signup.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  //repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());


  //usecase
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
}
