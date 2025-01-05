import 'dart:developer';

import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/presentation/home/bloc/bus_position/bus_position_cubit.dart';
import 'package:bus_tracking/presentation/home/widgets/bus_position_on_route.dart';
import 'package:flutter/material.dart';

import 'package:bus_tracking/common/helpers/is_dark_mode.dart';
import 'package:bus_tracking/common/helpers/time.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BusRouteDetails extends StatelessWidget {
  const BusRouteDetails({
    super.key,
    required this.bus,
  });

  final BusEntity bus;

  @override
  Widget build(BuildContext context) {
    log("Bus route updated");
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Route Stops',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bus.routes.stops.length,
                    itemBuilder: (context, index) {
                      final stop = bus.routes.stops[index];
                      final isLast = index == bus.routes.stops.length - 1;
                      String expectedArrivalTime;
                      String expectedDelayTime;

                      if (index == 0) {
                        expectedArrivalTime = convertToISTAndAddTime(
                          DateTime.parse(bus.startTime),
                          0,
                        );
                        expectedDelayTime = convertToISTAndAddTime(
                          DateTime.parse(bus.startTime),
                          0 + bus.routes.delayInSeconds,
                        );
                      } else {
                        int totalDuration = 0;
                        for (int i = 0; i < index; i++) {
                          totalDuration +=
                              bus.routes.stops[i].durationToNextStop;
                        }
                        expectedArrivalTime = convertToISTAndAddTime(
                          DateTime.parse(bus.startTime),
                          totalDuration,
                        );
                        expectedDelayTime = convertToISTAndAddTime(
                          DateTime.parse(bus.startTime),
                          totalDuration + bus.routes.delayInSeconds,
                        );
                      }
                      final String currentDate =
                          DateFormat("yyyy-MM-dd").format(DateTime.now());
                      final String startDate = DateFormat("yyyy-MM-dd")
                          .format(DateTime.parse(bus.startTime).toLocal());

                      final DateFormat dateTimeFormat =
                          DateFormat("yyyy-MM-dd hh:mm a");

                      final DateTime expectedDelayDateTime = dateTimeFormat
                          .parse("$currentDate $expectedDelayTime");

                      final DateTime expectedArrivalDateTime = dateTimeFormat
                          .parse("$startDate $expectedArrivalTime");

                      log(expectedDelayDateTime.toString());
                      log(expectedArrivalDateTime.toString());
                      final busPositionCubit = context.read<BusPositionCubit>();
                      final busPositionIndex =
                          busPositionCubit.state.busPosition.index;

                      Color textColor;
                      if (expectedArrivalDateTime
                          .isAfter(expectedDelayDateTime)) {
                        textColor = Colors.green;
                      } else if (expectedArrivalDateTime
                          .isAtSameMomentAs(expectedDelayDateTime)) {
                        textColor = Colors.blue;
                      } else {
                        textColor = Colors.red;
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    expectedArrivalTime,
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (busPositionIndex < index && bus.status == "Running")
                                    Text(
                                      expectedDelayTime,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 14,
                                      ),
                                    )
                                ],
                              ),
                              const SizedBox(width: 8),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      if (!isLast)
                                        Container(
                                          width: 4,
                                          height: 80,
                                          color: context.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stop.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!isLast)
                                Text(
                                  "${(stop.distanceToNextStop / 1000).toStringAsFixed(2)} km",
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          BusPositionOnRoute(
            bus: bus,
          ),
        ],
      ),
    );
  }
}
