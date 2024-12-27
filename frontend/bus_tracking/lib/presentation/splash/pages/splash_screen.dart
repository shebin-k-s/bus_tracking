import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/presentation/main/pages/main_screen.dart';
import 'package:bus_tracking/presentation/onboarding/bloc/carousel/carousel_cubit.dart';
import 'package:bus_tracking/presentation/onboarding/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkUserLoggedin(context);
    return const Scaffold(
      body: Center(
        child: Text(
          "Bus Tracking",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void checkUserLoggedin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    final sharedPref = await SharedPreferences.getInstance();

    final token = sharedPref.getString('TOKENs');

    if (token != null) {
      AppNavigator.pushReplacement(context, const MainScreen());
    } else {
      AppNavigator.pushReplacement(
        context,
        BlocProvider(
          create: (context) => CarouselCubit(),
          child: OnboardingScreen(),
        ),
      );
       }
  }
}

