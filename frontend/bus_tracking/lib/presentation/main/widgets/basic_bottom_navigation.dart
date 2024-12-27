import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/core/configs/assets/app_vectors.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/presentation/main/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BasicBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BasicBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
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
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: context.isDarkMode
          ? Colors.white.withOpacity(0.5)
          : Colors.black.withOpacity(0.5),
      selectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
      unselectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
      onTap: (value) =>
          context.read<BottomNavigationCubit>().updateIndex(value),
      backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
      type: BottomNavigationBarType.fixed,
    );
  }
}
