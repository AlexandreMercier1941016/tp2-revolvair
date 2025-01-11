class LatestStation {
  final String value;
  final String unit;
  final String date;
  final String stationId;
  LatestStation({required this.value,required this.unit,required this.date,required this.stationId});
  
   factory LatestStation.fromJson(Map<String, dynamic> json) {
    return LatestStation(
        value: json['value'].toString(),
        unit: json['unit'].toString(),
        date: json['date'].toString(),
        stationId: json['station_id'].toString());
  }
  
  @override
  String toString() {
    return 'Station{value: $value,unit: $unit,date: $date, stationId: $stationId}';
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'unit': unit,
      'date': date,
      'station_id': stationId
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LatestStation &&
            runtimeType == other.runtimeType &&
            value == other.value &&
            unit == other.unit &&
            stationId == other.stationId;
  }

  @override
  int get hashCode {
    return value.hashCode ^ unit.hashCode  ^ date.hashCode  ^ stationId.hashCode;
  }
}