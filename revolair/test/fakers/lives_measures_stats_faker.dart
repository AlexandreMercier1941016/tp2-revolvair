import 'package:faker/faker.dart';
import 'package:revolvair/domain/entities/measures_station/lives_measures_station.dart';

import 'faker_factory.dart';

class LivesMeasuresStatsFaker implements FakerFactory<LivesMeasuresStation>{

  @override
  LivesMeasuresStation create() {
    return LivesMeasuresStation(
      unit: faker.lorem.word(),
      value: faker.randomGenerator.decimal().toString(),
      date: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<List<LivesMeasuresStation>> createMany(int amount) {
    return Future.value(List.generate(amount, (index) => create()));
  }
}