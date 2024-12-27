import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/presentation/profile/bloc/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TextButton(
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme(
                  context.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            },
            child: const Text("Change Mode")),
      ),
    );
  }
}
