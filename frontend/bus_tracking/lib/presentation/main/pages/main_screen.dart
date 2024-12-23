import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/core/configs/assets/app_vectors.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/presentation/main/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bus_tracking/presentation/main/widgets/basic_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.isDarkMode ? Colors.black : Colors.white,
        statusBarIconBrightness:
            context.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppVectors.homeOutlined,
          width: 24,
          height: 24,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
        ),
        activeIcon: SvgPicture.asset(
          AppVectors.homeFilled,
          width: 24,
          height: 24,
          color: AppColors.primary,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppVectors.busOutlined,
          width: 24,
          height: 24,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
        ),
        activeIcon: SvgPicture.asset(
          AppVectors.busFilled,
          width: 24,
          height: 24,
          color: AppColors.primary,
        ),
        label: "My bus",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppVectors.ticketOutlined,
          width: 24,
          height: 24,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
        ),
        activeIcon: SvgPicture.asset(
          AppVectors.ticketFilled,
          width: 24,
          height: 24,
          color: AppColors.primary,
        ),
        label: "Tickets",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppVectors.profileOutlined,
          width: 24,
          height: 24,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
        ),
        activeIcon: SvgPicture.asset(
          AppVectors.profileFilled,
          width: 24,
          height: 24,
          color: AppColors.primary,
        ),
        label: "Profile",
      ),
    ];
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.selectedIndex,
              children: const [
                Center(child: Text('Home Screen')),
                Center(child: Text('Profile Screen')),
                Center(child: Text('Search Screen')),
                Center(child: Text('Profile Screen')),
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
                items: items,
              ),
            ),
          );
        },
      ),
    );
  }
}
