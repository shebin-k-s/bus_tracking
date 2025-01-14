import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/helpers/time.dart';
import 'package:bus_tracking/common/widgets/button/basic_app_button.dart';
import 'package:bus_tracking/core/navigation_keys/navigation_keys.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusCard extends StatelessWidget {
  const BusCard({
    super.key,
    required this.bus,
  });

  final BusEntity bus;

  Color _getStatusColor() {
    if (bus.status == 'Running') {
      return Colors.green;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final statusColor = _getStatusColor();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context, statusColor),
          _buildBody(context, statusColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: BasicAppButton(
              onPressed: () {
                GlobalNavigatorKeys.navigatorKeys[0].currentState?.pushNamed(
                  "/track",
                  arguments: {"bus": bus},
                );
              },
              title: "Track Live Location",
              height: 44.h,
              width: double.infinity,
              titleSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color statusColor) {
    final isDark = context.isDarkMode;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252525) : Colors.grey[50],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.directions_bus,
                  color: isDark ? Colors.white : Colors.black,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  bus.busNumber,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  bus.status,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, Color statusColor) {
    final isDark = context.isDarkMode;

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeInfo(
                context,
                "Departure",
                convertToISTAndAddTime(
                  DateTime.parse(bus.startTime),
                  0,
                ),
                Icons.schedule,
              ),
              _buildTimeInfo(
                context,
                "Arrival",
                _calculateArrivalTime(),
                Icons.flag_outlined,
              ),
            ],
          ),
          if (bus.routes.delayInSeconds > 0 && bus.status == "Running")
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "Delayed by ${_formatDelay(bus.routes.delayInSeconds)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF252525) : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                _buildRouteIndicator(statusColor),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStopInfo(
                        context,
                        bus.routes.stops.first.name,
                        "From",
                      ),
                      SizedBox(height: 16.h),
                      _buildStopInfo(
                        context,
                        bus.routes.stops.last.name,
                        "To",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(
      BuildContext context, String label, String time, IconData icon) {
    final isDark = context.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
            SizedBox(width: 4.w),
            Text(
              time,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRouteIndicator(Color statusColor) {
    return Column(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 2.w,
          height: 40.h,
          color: statusColor.withOpacity(0.3),
        ),
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: statusColor,
              width: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStopInfo(BuildContext context, String stopName, String label) {
    final isDark = context.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          stopName,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _calculateArrivalTime() {
    int totalDuration = bus.routes.stops.fold(
      0,
      (sum, stop) => sum + stop.durationToNextStop,
    );
    return convertToISTAndAddTime(
      DateTime.parse(bus.startTime),
      totalDuration + (bus.status == "Running" ? bus.routes.delayInSeconds : 0),
    );
  }

  String _formatDelay(int delayInSeconds) {
    final int minutes = delayInSeconds ~/ 60;
    final int hours = minutes ~/ 60;
    final int remainingMinutes = minutes % 60;

    if (hours > 0) {
      return "$hours hr ${remainingMinutes} min";
    } else {
      return "$remainingMinutes min";
    }
  }
}
