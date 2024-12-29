part of 'bus_cubit.dart';

@immutable
sealed class BusState {}

final class BusLoading extends BusState {}

final class BusLoaded extends BusState {
  final List<BusEntity> buses;

  BusLoaded({required this.buses});
}
