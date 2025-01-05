import 'dart:ui';
import 'package:bus_tracking/core/configs/theme/app_colors.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/presentation/home/bloc/bus_position/bus_position_cubit.dart';
import 'package:bus_tracking/presentation/home/bloc/map/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    super.key,
    required this.busStops,
  });

  final List<Stop> busStops;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(busStops)..initialize(),
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<BusPositionCubit, UpdatedBusPosition>(
              builder: (context, busState) {
                context
                    .read<MapCubit>()
                    .updateBusPosition(busState.busPosition.coordinates);
                return BlocBuilder<MapCubit, MapState>(
                  builder: (context, mapState) {
                    if (mapState is MapLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    if (mapState is MapLoadedState) {
                      return GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: busState.busPosition.coordinates,
                          zoom: 15,
                        ),
                        polylines: { 
                          Polyline(
                            polylineId: const PolylineId("route"),
                            points: mapState.polylineCoordinates,
                            color: Colors.green,
                            width: 5,
                          ),
                        },
                        markers: mapState.markers,
                        onMapCreated: (controller) {
                          context.read<MapCubit>().setMapController(controller);
                        },
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 100,
                            sigmaY: 100,
                          ),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                  0.2), // Semi-transparent background
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      // Foreground content
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
