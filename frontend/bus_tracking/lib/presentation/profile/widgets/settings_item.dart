import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.showToggle = false,
    this.isToggled = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showToggle;
  final bool isToggled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 24,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: context.isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
            if (showToggle)
              Switch(
                activeColor: Colors.white,
                activeTrackColor: AppColors.primary,
                value: isToggled,
                onChanged: (_) => onTap(),
              )
            else
              Icon(
                Icons.chevron_right,
                color: context.isDarkMode ? Colors.white54 : Colors.black54,
              ),
          ],
        ),
      ),
    );
  }
}
