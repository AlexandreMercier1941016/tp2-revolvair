class LatestMeasuresStations {
  final String value;
  final String unit;
  final String date;

  LatestMeasuresStations({
    required this.value,
    required this.unit,
    required this.date,
  });

  factory LatestMeasuresStations.fromJson(Map<String, dynamic> json) {
    var firstElement = json['data'][0];
    return LatestMeasuresStations(
      value: firstElement['value'].toString(),
      unit: firstElement['unit'].toString(),
      date: firstElement['date'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data':[ {
      'value': value,
      'unit': unit,
      'date': date,
      }
      ] 
    };
  }

  @override
  String toString() {
    return 'LatestMeasuresStations{value: $value, unit: $unit, date: $date}';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LatestMeasuresStations &&
            runtimeType == other.runtimeType &&
            value == other.value &&
            unit == other.unit &&
            date == other.date;
  }

  @override
  int get hashCode {
    return value.hashCode ^ unit.hashCode ^ date.hashCode;
  }

  factory LatestMeasuresStations.empty() {
    return LatestMeasuresStations(value: '', unit: '', date: DateTime.now().toString());
  }
}