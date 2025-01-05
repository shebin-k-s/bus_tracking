import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/presentation/profile/bloc/user_details/user_details_cubit.dart';
import 'package:bus_tracking/presentation/profile/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/presentation/profile/bloc/theme/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    context.read<UserDetailsCubit>().loadUserDetails();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.1)
                              : Colors.blue.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          size: 60,
                          color:
                              context.isDarkMode ? Colors.white : Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<UserDetailsCubit, UserDetailsState>(
                        builder: (context, state) {
                          final String fullName = state is UserDetailsLoaded
                              ? state.fullName
                              : "....";
                          final String email =
                              state is UserDetailsLoaded ? state.email : "....";
                          return Column(
                            children: [
                              Text(
                                fullName,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: context.isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      if (!context.isDarkMode)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SettingsItem(
                        title: 'App Theme',
                        icon: Icons.palette_outlined,
                        onTap: () {
                          context.read<ThemeCubit>().toggleTheme(
                                context.isDarkMode
                                    ? ThemeMode.light
                                    : ThemeMode.dark,
                              );
                        },
                        showToggle: true,
                        isToggled: context.isDarkMode,
                      ),
                      _buildDivider(context),
                      SettingsItem(
                        title: 'Privacy Policy',
                        icon: Icons.privacy_tip_outlined,
                        onTap: () {},
                      ),
                      _buildDivider(context),
                      SettingsItem(
                        title: 'Terms of Service',
                        icon: Icons.description_outlined,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                BasicAppButton(
                  onPressed: () async {
                    final sharedPref = await SharedPreferences.getInstance();
                    await sharedPref.clear();
                    onLogout();
                  },
                  title: "Logout",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.isDarkMode
          ? Colors.white.withOpacity(0.1)
          : Colors.grey.withOpacity(0.1),
    );
  }
}
