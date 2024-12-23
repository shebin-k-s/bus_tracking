
import 'package:bus_tracking/core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;


void setupServiceLocator() {

  sl.registerSingleton<DioClient>(DioClient());
  
}
