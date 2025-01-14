part of 'ticket_cubit.dart';

@immutable
sealed class TicketState {}


class TicketLoading extends TicketState{}

class TicketLoaded extends TicketState{
  final int ticketCount;

  TicketLoaded({required this.ticketCount});
}

