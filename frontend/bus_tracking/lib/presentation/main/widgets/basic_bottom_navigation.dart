import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/presentation/main/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicBottomNavigation extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;

  const BasicBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
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
