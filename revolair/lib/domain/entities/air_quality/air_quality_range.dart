class AirQualityRange {
  final String description;
  final int min;
  final int max;
  final String color;
  final String healthEffect;
  final String note;
  final String icon;

  AirQualityRange(
      {required this.description,
      required this.min,
      required this.max,
      required this.color,
      required this.healthEffect,
      required this.note,
      required this.icon});
  factory AirQualityRange.fromJson(Map<String, dynamic> json) {
    return AirQualityRange(
        description: json['label'].toString(),
        min: int.parse(json['min'].toString()),
        max: int.parse(json['max'].toString()),
        color: json['color'].toString(),
        healthEffect: json['health_effect'].toString(),
        note: json['note'].toString(),
        icon: json['icon'].toString());
  }
  @override
  String toString() {
    return 'AirQualityRange{description: $description,min: $min,max:$max,color:$color,health_effect:$healthEffect,note:$note, icon: $icon}';
  }

  Map<String, dynamic> toJson() {
    return {
      'label': description,
      'min': min,
      'max': max,
      'color': color,
      'health_effect': healthEffect,
      'note': note,
      'icon': icon
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AirQualityRange &&
            runtimeType == other.runtimeType &&
            description == other.description &&
            min == other.min &&
            max == other.max &&
            healthEffect == other.healthEffect &&
            note == other.note &&
            color == other.color &&
            icon == other.icon;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        min.hashCode ^
        max.hashCode ^
        color.hashCode ^
        healthEffect.hashCode ^
        note.hashCode ^
        icon.hashCode;
  }
}
