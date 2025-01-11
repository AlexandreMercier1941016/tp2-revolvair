import 'package:revolvair/domain/entities/measures_station/latest%20stats/latest_stats.dart';

class StationInfos {
  final LatestStats? latestStats;
  final String latestPm25Measures;
  final String latestMeasuresDateTime;

  StationInfos(
      {required this.latestStats,
      required this.latestPm25Measures,
      required this.latestMeasuresDateTime});

  factory StationInfos.fromJson(Map<String, dynamic> json) {
    return StationInfos(
        latestStats: LatestStats.fromJson(json),
        latestPm25Measures: json['stats']['latestPm25Measures'].toString(),
        latestMeasuresDateTime: json['stats']['latestMeasuresDateTime'].toString());
  }

  @override
  String toString() {
    return 'StationInfos{latestStats: $latestStats, latest_pm25_measures: $latestPm25Measures, latest_measures_date_time: $latestMeasuresDateTime}';
  }

  Map<String, dynamic> toJson() {
    return {
      'stats': {
      'average': latestStats?.averageLatestStats?.toJson(),
      'max': latestStats?.maxLatestStats?.toJson(),
      'latestPm25Measures': latestPm25Measures,
      'latestMeasuresDateTime': latestMeasuresDateTime.toString()
      }
    };
  }

  @override
  bool operator ==(Object other) {
   return 
        other is StationInfos &&
            latestStats == other.latestStats &&
            latestPm25Measures == other.latestPm25Measures &&
            latestMeasuresDateTime == other.latestMeasuresDateTime;
  }
/*
  @override
  int get hashCode {
    return latestStats.hashCode ^
        latestPm25Measures.hashCode ^
        latestMeasuresDateTime.hashCode;
  }
  */
  factory StationInfos.empty() {
  return StationInfos(latestStats: null, latestPm25Measures: '0', latestMeasuresDateTime: DateTime.now().toString());
  }


}