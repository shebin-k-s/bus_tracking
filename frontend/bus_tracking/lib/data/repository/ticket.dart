
import 'package:bus_tracking/data/source/ticket/ticket_api_service.dart';
import 'package:bus_tracking/domain/repository/ticket/ticket.dart';
import 'package:bus_tracking/service_locator.dart';
import 'package:dartz/dartz.dart';

class TicketRepositoryImpl extends TicketRepository {
  @override
  Future<Either> fetchTicket() {
    return sl<TicketApiService>().fetchTicket();
  }

}