
import 'package:bus_tracking/core/usecase/usecase.dart';
import 'package:bus_tracking/domain/repository/ticket/ticket.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';

class FetchTicketUsecase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({param}) {
    return sl<TicketRepository>().fetchTicket();
  }
}
