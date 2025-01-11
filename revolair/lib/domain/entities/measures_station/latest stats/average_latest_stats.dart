class AverageLatestStats {
  final String tenMinutes;
  final String thirtyMinutes;
  final String oneHour;
  final String sixHours;
  final String oneDay;
  final String oneWeek;

  AverageLatestStats({
    required this.tenMinutes,
    required this.thirtyMinutes,
    required this.oneHour,
    required this.sixHours,
    required this.oneDay,
    required this.oneWeek,
  });

  factory AverageLatestStats.fromJson(Map<String, dynamic> json) {
    var tabStat = json['average'];
    return AverageLatestStats(
      tenMinutes: tabStat['10m'].toString(),
      thirtyMinutes: tabStat['30m'].toString(),
      oneHour: tabStat['1h'].toString(),
      sixHours: tabStat['6h'].toString(),
      oneDay: tabStat['1d'].toString(),
      oneWeek: tabStat['1w'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '10m': tenMinutes,
      '30m': thirtyMinutes,
      '1h': oneHour,
      '6h': sixHours,
      '1d': oneDay,
      '1w': oneWeek,
    };
  }

  @override
  String toString() {
    return 'AverageLatestStats{tenMinutes: $tenMinutes, thirtyMinutes: $thirtyMinutes, oneHour: $oneHour, sixHours: $sixHours, oneDay: $oneDay, oneWeek: $oneWeek}';
  }

  @override

  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AverageLatestStats &&
            tenMinutes == other.tenMinutes &&
            thirtyMinutes == other.thirtyMinutes &&
            oneHour == other.oneHour &&
            sixHours == other.sixHours &&
            oneDay == other.oneDay &&
            oneWeek == other.oneWeek;
  }

  @override
  int get hashCode {
    return tenMinutes.hashCode ^
        thirtyMinutes.hashCode ^
        oneHour.hashCode ^
        sixHours.hashCode ^
        oneDay.hashCode ^
        oneWeek.hashCode;
  }
}