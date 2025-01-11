class LivesMeasuresStation {

final String unit;
final String value;
final String date;

LivesMeasuresStation({required this.unit, required this.value, required this.date});
factory LivesMeasuresStation.fromJson(Map<String, dynamic> json) {
   var tabData = json['data'];
return LivesMeasuresStation(
unit: tabData['unit'].toString(),
value: tabData['value'].toString(),
date: tabData['date'].toString());
}

@override
String toString() {
return 'LivesMeasuresStation{unit: $unit, value: $value, date: $date}';
}

Map<String, dynamic> toJson() {
return {
'data': {
'unit': unit,
'value': value,
'date': date  
}
};
}

@override
bool operator ==(Object other) {
return identical(this, other) ||
other is LivesMeasuresStation &&
runtimeType == other.runtimeType &&
unit == other.unit &&
value == other.value &&
date == other.date;
}

@override
int get hashCode {
return unit.hashCode ^ value.hashCode ^ date.hashCode;
}

factory LivesMeasuresStation.empty() {
return LivesMeasuresStation(unit: '', value: "", date: DateTime.now().toString());}

}