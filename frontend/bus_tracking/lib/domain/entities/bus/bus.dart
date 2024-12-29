// ignore_for_file: public_member_api_docs, sort_constructors_first
class BusEntity {
  Location currentLocation;
  String busNumber;
  Routes routes;
  String driverName;
  String driverNumber;
  String status;
  String startTime;


  BusEntity({
    required this.currentLocation,
    required this.busNumber,
    required this.routes,
    required this.driverName,
    required this.driverNumber,
    required this.status,
    required this.startTime,
  });

  factory BusEntity.fromJson(Map<String, dynamic> json) {
    return BusEntity(
      currentLocation: Location.fromJson(json['currentLocation']),
      busNumber: json['busNumber'],
      routes: Routes.fromJson(json['routeId']),
      driverName: json['driverName'],
      driverNumber: json['driverNumber'],
      status: json['status'],
      startTime: json['startTime'],
    );
  }
}

class Location {
  List<double> coordinates;

  Location({
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}

class Routes {
  List<Stop> stops;

  Routes({
    required this.stops,
  });

  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
      stops: (json['stops'] as List)
          .map((stop) => Stop.fromJson(stop as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Stop {
  Location location;
  int distanceToNextStop;
  int durationToNextStop;
  String name;

  Stop({
    required this.location,
    required this.distanceToNextStop,
    required this.durationToNextStop,
    required this.name,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      location: Location.fromJson(json['location']),
      distanceToNextStop: json['distanceToNextStop'],
      durationToNextStop: json['durationToNextStop'],
      name: json['name'],
    );
  }
}
