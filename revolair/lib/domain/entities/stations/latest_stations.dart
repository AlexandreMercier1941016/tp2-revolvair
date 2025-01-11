import 'package:collection/collection.dart';
import 'package:revolvair/domain/entities/stations/latest_station.dart';

class LatestStations {
  final List<LatestStation> latestStations;

  LatestStations({required this.latestStations});
  factory LatestStations.fromJson(Map<String, dynamic> json) {
    return LatestStations(
        latestStations: List<LatestStation>.from(
            json['data'].map((station) => LatestStation.fromJson(station))));
  }
  @override
  String toString() {
    return "LatestStations(latestStations: $latestStations)";
  }
   Map<String, dynamic> toJson() {
    return {
      'data': latestStations.map((latestStation) => latestStation.toJson()).toList()
    };
  }
   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LatestStations &&
        const ListEquality().equals(other.latestStations, latestStations);
  }

  @override
  int get hashCode {
    return latestStations.hashCode;
  }
}
