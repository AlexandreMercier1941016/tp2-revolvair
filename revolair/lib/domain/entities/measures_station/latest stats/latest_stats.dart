import 'package:revolvair/domain/entities/measures_station/latest%20stats/average_latest_stats.dart';
import 'package:revolvair/domain/entities/measures_station/latest%20stats/max_latest_stats.dart';

class LatestStats {

  final AverageLatestStats? averageLatestStats;
  final MaxLatestStats? maxLatestStats;

  LatestStats({
    this.averageLatestStats,
    this.maxLatestStats,
  });

  factory LatestStats.fromJson(Map<String, dynamic> json) {
    return LatestStats(
      averageLatestStats: AverageLatestStats.fromJson(json['stats']),
      maxLatestStats: MaxLatestStats.fromJson(json['stats']),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average': averageLatestStats?.toJson(),
      'max': maxLatestStats?.toJson(),
    };
  }

  @override
  String toString() {
    return 'LatestStats{averageLatestStats: $averageLatestStats, maxLatestStats: $maxLatestStats}';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LatestStats &&
            averageLatestStats == other.averageLatestStats &&
            maxLatestStats == other.maxLatestStats;
  }

  @override
  int get hashCode {
    return averageLatestStats.hashCode ^
        maxLatestStats.hashCode;
  }
}