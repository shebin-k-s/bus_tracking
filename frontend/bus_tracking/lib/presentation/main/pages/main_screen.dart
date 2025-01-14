import 'dart:developer';

import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/helpers/navigation.dart';
import 'package:bus_tracking/core/navigation_keys/navigation_keys.dart';
import 'package:bus_tracking/presentation/home/bloc/bus/bus_cubit.dart';
import 'package:bus_tracking/presentation/home/bloc/bus_position/bus_position_cubit.dart';
import 'package:bus_tracking/presentation/home/pages/home_navigator_screen.dart';
import 'package:bus_tracking/presentation/main/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bus_tracking/presentation/main/widgets/basic_bottom_navigation.dart';
import 'package:bus_tracking/presentation/onboarding/bloc/carousel/carousel_cubit.dart';
import 'package:bus_tracking/presentation/onboarding/pages/onboarding_screen.dart';
import 'package:bus_tracking/presentation/profile/pages/profile_navigator_screen.dart';
import 'package:bus_tracking/presentation/ticket/pages/ticket_navigator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Future<bool> systemBackButtonPress(int index) async {
    if (GlobalNavigatorKeys.navigatorKeys[index].currentState?.canPop() ==
        true) {
      GlobalNavigatorKeys.navigatorKeys[index].currentState?.pop();
      return false;
    } else {
      final shouldExit = await showDialog<bool>(
        context: GlobalNavigatorKeys.navigatorKeys[index].currentContext!,
        builder: (context) => AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        ),
      );
      return shouldExit ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<BusCubit>().reset();
    context.read<BusPositionCubit>().reset();
    context.read<BottomNavigationCubit>().reset();

    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        log(state.selectedIndex.toString());
        return WillPopScope(
          onWillPop: () => systemBackButtonPress(state.selectedIndex),
          child: Scaffold(
            body: IndexedStack(
              index: state.selectedIndex,
              children: [
                const HomeNavigatorScreen(
                  navigatorIndex: 0,
                ),
                const TicketNavigatorScreen(
                  navigatorIndex: 1,
                ),
                const TicketNavigatorScreen(
                  navigatorIndex: 2,
                ),
                ProfileNavigatorScreen(
                  navigatorIndex: 3,
                  onLogout: () => AppNavigator.pushAndRemoveUntil(
                    context,
                    BlocProvider(
                      create: (context) => CarouselCubit(),
                      child: OnboardingScreen(),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.3)
                      : Colors.black.withOpacity(0.3),
                  offset: const Offset(0, -1),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ]),
              child: BasicBottomNavigation(
                currentIndex: state.selectedIndex,
              ),
            ),
          ),
        );
      },
    );
  }
}
