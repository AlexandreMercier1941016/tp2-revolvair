import 'package:faker/faker.dart';
import 'package:revolvair/domain/entities/stations/station.dart';
import 'package:revolvair/domain/entities/stations/stations.dart';

import 'faker_factory.dart';

class StationsFaker implements FakerFactory<Stations> {
  @override
  Stations create() {
    return Stations(stations: List<Station>.generate(
      5,
      (_) => Station(id: faker.animal.name(), lat: faker.address.city(),slug: faker.company.name(), long: faker.color.color())
    ));
  }

  @override
  Future<List<Stations>> createMany(int amount) {
   return Future.value(List.empty());
  }

}