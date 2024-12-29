import 'package:dartz/dartz.dart';

abstract class BusRepository{

  Future<Either> fetchBuses();

}