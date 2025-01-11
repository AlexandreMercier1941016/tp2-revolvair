import 'package:faker/faker.dart';
import 'package:revolvair/domain/entities/measures_station/latest_measures_stations.dart';
import 'faker_factory.dart';

class LatestMeasuresStationsFaker implements FakerFactory<LatestMeasuresStations> {
  @override
  LatestMeasuresStations create() {
    return LatestMeasuresStations(
      value: faker.randomGenerator.decimal().toString(),
      unit: faker.lorem.word(),
      date: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<List<LatestMeasuresStations>> createMany(int amount) {
    return Future.value(List.generate(amount, (index) => create()));
  }
}
