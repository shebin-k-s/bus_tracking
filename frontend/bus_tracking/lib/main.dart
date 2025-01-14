import 'package:bus_tracking/core/configs/theme/app_theme.dart';
import 'package:bus_tracking/presentation/home/bloc/bus/bus_cubit.dart';
import 'package:bus_tracking/presentation/home/bloc/bus_position/bus_position_cubit.dart';
import 'package:bus_tracking/presentation/main/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bus_tracking/presentation/profile/bloc/theme/theme_cubit.dart';
import 'package:bus_tracking/presentation/profile/bloc/user_details/user_details_cubit.dart';
import 'package:bus_tracking/presentation/splash/pages/splash_screen.dart';
import 'package:bus_tracking/presentation/ticket/bloc/ticket/ticket_cubit.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ThemeCubit(),
            ),
            BlocProvider(
              create: (context) => BusCubit(),
            ),
            BlocProvider(
              create: (context) => TicketCubit(),
            ),
            BlocProvider(
              create: (context) => BusPositionCubit(),
            ),
            BlocProvider(
              create: (context) => BottomNavigationCubit(),
            ),
            BlocProvider(
              create: (context) => UserDetailsCubit(),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  statusBarColor:
                      state == ThemeMode.dark ? Colors.black : Colors.white,
                  statusBarIconBrightness: state == ThemeMode.dark
                      ? Brightness.light
                      : Brightness.dark,
                ),
              );
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: state,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                home: const SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
