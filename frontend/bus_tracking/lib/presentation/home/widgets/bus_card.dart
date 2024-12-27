import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/core/configs/assets/app_vectors.dart';
import 'package:bus_tracking/core/navigation_keys/navigation_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BusCard extends StatelessWidget {
  const BusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildCardHeader(context),
          const SizedBox(height: 20),
          _buildCardBody(context),
        ],
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _headerItem(
          icon: Icons.update,
          label: 'LAST UPDATE',
          value: '20 min ago',
        ),
        _headerItem(
          iconWidget: SvgPicture.asset(
            AppVectors.busOutlined,
            color: context.isDarkMode ? Colors.white : Colors.black,
            height: 24,
          ),
          label: 'BUS NO',
          value: 'KL87652',
        ),
        _headerItem(
          icon: Icons.next_plan_outlined,
          label: 'UPDATED STOP',
          value: 'Vallapuzha',
        ),
      ],
    );
  }

  Widget _headerItem({
    IconData? icon,
    Widget? iconWidget,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        iconWidget ??
            Icon(
              icon,
              size: 24.sp,
            ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildCardBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRouteDetails(context),
        _buildTimingDetails(context),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildRouteDetails(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            const Icon(Icons.circle_outlined, size: 20),
            SizedBox(
              height: 30,
              child: SvgPicture.asset(
                AppVectors.dottedLine,
                width: 15,
                fit: BoxFit.fill,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const Icon(Icons.location_on_outlined),
          ],
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80.w,
              child: Text(
                "pattambi",
                style: TextStyle(fontSize: 14.sp),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 33),
            SizedBox(
              width: 80.w,
              child: Text(
                "pattambi",
                style: TextStyle(fontSize: 14.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimingDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timingRow(
          icon: Icons.timer_outlined,
          time: "8:00 AM",
        ),
        const SizedBox(height: 33),
        _timingRow(
          icon: Icons.timer_outlined,
          time: "8:00 AM",
        ),
      ],
    );
  }

  Widget _timingRow({required IconData icon, required String time}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14.sp,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        BasicAppButton(
          onPressed: () {
            GlobalNavigatorKeys.navigatorKeys[0].currentState
                ?.pushNamed('/ticket');
          },
          title: "Check Tickets",
          width: 120.w,
          height: 35.w,
          titleSize: 13.sp,
        ),
        const SizedBox(
          height: 20,
        ),
        BasicAppButton(
          onPressed: () {},
          title: "Track Bus",
          width: 120.w,
          height: 35.w,
          titleSize: 13.sp,
        ),
      ],
    );
  }
}
