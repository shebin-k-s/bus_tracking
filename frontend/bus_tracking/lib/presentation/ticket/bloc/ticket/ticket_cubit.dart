import 'package:bloc/bloc.dart';
import 'package:bus_tracking/domain/usecases/ticket/fetch_ticket.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(TicketLoading());

  void fetchTicket() async {
    Either result = await sl<FetchTicketUsecase>().call();

    result.fold(
      (error) async {
        await Future.delayed(
          const Duration(seconds: 5),
        );
        fetchTicket();
      },
      (data) {
        emit(TicketLoaded(ticketCount: data));
      },
    );
  }
}
