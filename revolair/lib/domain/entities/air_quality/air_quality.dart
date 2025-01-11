import 'air_quality_range.dart';
import 'package:collection/collection.dart';

class AirQuality {
  final String name;
  final String description;
  final List<AirQualityRange> ranges;
  final String source;
  final String url;

  AirQuality(
      {required this.name,
      required this.description,
      required this.ranges,
      required this.source,
      required this.url});
  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
        name: json['name'].toString(),
        description: json['description'].toString(),
        source: json['source'].toString(),
        url: json['url'].toString(),
        ranges: List<AirQualityRange>.from(
            json['ranges'].map((range) => AirQualityRange.fromJson(range))));
  }
  @override
  String toString() {
    return 'AirQuality{name: $name, description: $description,source: $source, url: $url ,ranges: $ranges}';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AirQuality &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            source == other.source &&
            url == other.url &&
            description == other.description &&
            const ListEquality().equals(ranges, other.ranges);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        source.hashCode ^
        url.hashCode ^
        ranges.hashCode;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'source': source,
      'url': url,
      'ranges': ranges.map((range) => range.toJson()).toList()
    };
  }

  factory AirQuality.empty() {
    return AirQuality(
        name: '',
        description: '',
        source: '',
        url: '',
        ranges: []);
  }
}
