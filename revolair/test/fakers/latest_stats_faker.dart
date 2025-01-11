import 'package:faker/faker.dart';
import 'package:revolvair/domain/entities/measures_station/latest%20stats/average_latest_stats.dart';
import 'package:revolvair/domain/entities/measures_station/latest%20stats/max_latest_stats.dart';
import 'package:revolvair/domain/entities/measures_station/latest%20stats/latest_stats.dart';

// Faker pour AverageLatestStats
class AverageLatestStatsFaker {
  static AverageLatestStats create() {
    return AverageLatestStats(tenMinutes: faker.company.name(), thirtyMinutes: faker.company.name(), oneHour: faker.company.name(), sixHours: faker.company.name(), oneDay: faker.company.name(), oneWeek: faker.company.name());
  }
}

// Faker pour MaxLatestStats
class MaxLatestStatsFaker {
  static MaxLatestStats create() {
    return MaxLatestStats(
      oneDay: faker.company.name(),
      oneWeek: faker.company.name(),
    );
  }
}

// Faker pour LatestStats
class LatestStatsFaker {
  static LatestStats create() {
    return LatestStats(
      averageLatestStats: AverageLatestStatsFaker.create(),
      maxLatestStats: MaxLatestStatsFaker.create(),
    );
  }

  static Future<List<LatestStats>> createMany(int count) async {
    return List.generate(count, (index) => create());
  }
}
