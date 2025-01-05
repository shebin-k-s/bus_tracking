import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/core/configs/assets/app_vectors.dart';
import 'package:bus_tracking/presentation/main/pages/main_screen.dart';
import 'package:bus_tracking/presentation/onboarding/bloc/carousel/carousel_cubit.dart';
import 'package:bus_tracking/presentation/onboarding/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkUserLoggedin(context);
    return Scaffold(
      body: SvgPicture.asset(
        AppVectors.appIcon,
        color: context.isDarkMode ? Colors.white : const Color(0xff142e3d),
      ),
    );
  }

  void checkUserLoggedin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    final sharedPref = await SharedPreferences.getInstance();

    final token = sharedPref.getString('TOKEN');

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
