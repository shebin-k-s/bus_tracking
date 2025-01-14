import 'package:dartz/dartz.dart';

abstract class TicketRepository {
  Future<Either> fetchTicket();
}