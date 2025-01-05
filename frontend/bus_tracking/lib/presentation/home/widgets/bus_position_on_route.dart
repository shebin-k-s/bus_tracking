import 'dart:developer';

import 'package:bus_tracking/common/helpers/delay_calculator.dart';
import 'package:bus_tracking/common/helpers/find_bus_location.dart';
import 'package:bus_tracking/core/constants/api_urls.dart';
import 'package:bus_tracking/domain/entities/bus/bus.dart';
import 'package:bus_tracking/domain/entities/bus/bus_position.dart';
import 'package:bus_tracking/presentation/home/bloc/bus/bus_cubit.dart';
import 'package:bus_tracking/presentation/home/bloc/bus_position/bus_position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BusPositionOnRoute extends StatefulWidget {
  const BusPositionOnRoute({
    super.key,
    required this.bus,
  });

  final BusEntity bus;

  @override
  State<BusPositionOnRoute> createState() => _BusPositionOnRouteState();
}

class _BusPositionOnRouteState extends State<BusPositionOnRoute> {
  late IO.Socket _socket;
  late BusCubit _busCubit;
  void _connectToSocket() {
    _socket = IO.io(
      ApiUrls.baseURL,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      print('Connected to socket');
      _socket.emit('joinBusSocket', {'busId': widget.bus.id});
    });

    _socket.on('busLocation', (data) {
      log(data.toString());

      if (data['latitude'] != null && data['longitude'] != null) {
        final busPosition = findBusPosition(
          widget.bus.routes.stops,
          double.parse(data['latitude'].toString()),
          double.parse(data['longitude'].toString()),
        );

        context.read<BusPositionCubit>().updatePosition(busPosition);

        calculateDelay(busPosition);
      }
    });

    _socket.onDisconnect((_) {
      print('Disconnected from socket');
    });
  }

  void calculateDelay(BusPositionEntity busPosition) {
    final int delay = DelayCalculator.calculateDelay(
      DateTime.parse(widget.bus.startTime),
      widget.bus.routes.stops,
      busPosition.index,
      busPosition.progress,
      busPosition.coordinates,
    );

    _busCubit.updateStopDelaysAndBusLocation(
        widget.bus.id, delay, busPosition.coordinates);
  }

  @override
  void initState() {
    _connectToSocket();
    _busCubit = context.read<BusCubit>();
    if (widget.bus.currentLocation.coordinates.length == 2) {
      final data = findBusPosition(
        widget.bus.routes.stops,
        widget.bus.currentLocation.coordinates[1],
        widget.bus.currentLocation.coordinates[0],
      );
      context.read<BusPositionCubit>().updatePosition(data);

      calculateDelay(data);
    }

    super.initState();
  }

  @override
  void dispose() {
    _socket.disconnect();
    _socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusPositionCubit, UpdatedBusPosition>(
      builder: (context, state) {
        final busPosition = state.busPosition;
        return Positioned(
          top: 90 * busPosition.index + 90 * busPosition.progress + 20,
          left: 65,
          child: const SizedBox(
            width: 30,
            height: 30,
            child: Icon(
              Icons.location_on_outlined,
              color: Colors.red,
              size: 40,
            ),
          ),
        );
      },
    );
  }
}
