class MaxLatestStats {

  final String oneDay;
  final String oneWeek;

  MaxLatestStats({
    required this.oneDay,
    required this.oneWeek,
  });


  factory MaxLatestStats.fromJson(Map<String, dynamic> json) {
    var tabMax = json['max'];
    return MaxLatestStats(
      oneDay: tabMax['1d'].toString(),
      oneWeek: tabMax['1w'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '1d': oneDay,
      '1w': oneWeek,
    };
  }

  @override
  String toString() {
    return 'MaxLatestStats{oneDay: $oneDay, oneWeek: $oneWeek}';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MaxLatestStats &&
            runtimeType == other.runtimeType &&
            oneDay == other.oneDay &&
            oneWeek == other.oneWeek;
  }
  @override
  int get hashCode {
    return oneDay.hashCode ^
        oneWeek.hashCode;
  }
}