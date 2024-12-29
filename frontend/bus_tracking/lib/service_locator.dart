import 'package:bus_tracking/core/network/dio_client.dart';
import 'package:bus_tracking/data/repository/auth.dart';
import 'package:bus_tracking/data/repository/bus.dart';
import 'package:bus_tracking/data/source/auth/auth_api_service.dart';
import 'package:bus_tracking/data/source/bus/bus_api_service.dart';
import 'package:bus_tracking/domain/repository/auth/auth.dart';
import 'package:bus_tracking/domain/repository/bus/bus.dart';
import 'package:bus_tracking/domain/usecases/auth/signin.dart';
import 'package:bus_tracking/domain/usecases/auth/signup.dart';
import 'package:bus_tracking/domain/usecases/bus/bus.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<BusApiService>(BusApiServiceImpl());

  //repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<BusRepository>(BusRepositoryImpl());


  //usecase
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<FetchBusUseCase>(FetchBusUseCase());

}
