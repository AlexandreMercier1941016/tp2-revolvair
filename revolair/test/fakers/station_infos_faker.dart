import 'package:faker/faker.dart';
import 'package:revolvair/domain/entities/measures_station/station_infos.dart';

import 'faker_factory.dart';
import 'latest_stats_faker.dart';

class StationInfosFaker implements FakerFactory<StationInfos>{
  @override
   StationInfos create() {
    return StationInfos(
      latestStats: LatestStatsFaker.create(),
      latestPm25Measures: faker.randomGenerator.decimal().toString(),
      latestMeasuresDateTime: faker.date.dateTime(minYear: 2020, maxYear: 2024).toIso8601String(),
    );
  }

  @override
  Future<List<StationInfos>> createMany(int count) async {
    return List.generate(count, (index) => create());
  }
}