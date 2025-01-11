import 'package:collection/collection.dart';
import 'package:revolvair/domain/entities/stations/station.dart';

class Stations {
    final List<Station> stations;

  Stations({required this.stations});

   @override
  String toString() {
    return 'Stations{stations: $stations}';
  }
  factory Stations.fromJson(Map<String, dynamic> json) {
    return Stations(
        stations: List<Station>.from(
            json['data'].map((station) => Station.fromJson(station))));
  }
  Map<String, dynamic> toJson() {
    return {
      'data': stations.map((station) => station.toJson()).toList()
    };
  }
   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Stations &&
        const ListEquality().equals(other.stations, stations);
  }

  @override
  int get hashCode {
    return stations.hashCode;
  } 
}