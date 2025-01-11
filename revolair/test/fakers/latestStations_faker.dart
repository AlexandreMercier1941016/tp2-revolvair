import 'package:faker/faker.dart';
import 'package:revolvair/domain/entities/stations/latest_station.dart';
import 'package:revolvair/domain/entities/stations/latest_stations.dart';

import 'faker_factory.dart';

class LateststationsFaker implements FakerFactory<LatestStations> {
  @override
  LatestStations create() {
    return LatestStations(latestStations: List<LatestStation>.generate(
      5,
      (_) => LatestStation(value: faker.conference.name(), unit: faker.currency.name(), date: faker.animal.name(), stationId: faker.address.city())
    ));
  }

  @override
  Future<List<LatestStations>> createMany(int amount) {
   return Future.value(List.empty());
  }

}