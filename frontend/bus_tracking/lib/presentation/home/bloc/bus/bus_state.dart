part of 'bus_cubit.dart';

@immutable
sealed class BusState {}

final class BusLoading extends BusState {}

final class BusLoaded extends BusState {
  final List<BusEntity> buses;

  BusLoaded({required this.buses});

  BusLoaded copyWith({
    List<BusEntity>? buses,
  }) {
    return BusLoaded(
      buses: buses ?? this.buses,
    );
  }
}
