import 'package:faker/faker.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality_range.dart';
import 'faker_factory.dart';

class RevolvairAirQualityFaker implements FakerFactory<AirQuality> {

  @override
  Future<List<AirQuality>> createMany(int amount) async{
    return List.generate(amount, (index) => _createAirQuality());
  }

  @override
  AirQuality create() {
    return _createAirQuality();

  }

  AirQuality _createAirQuality() {
    return AirQuality(
        name: faker.person.name(),
        description: faker.address.city(),
        source: faker.color.color(),
        url: faker.company.name(),
        ranges: List<AirQualityRange>.generate(
            3,
            (_) => AirQualityRange(
                description: faker.address.city(),
                min: faker.randomGenerator.integer(300),
                max: faker.randomGenerator.integer(300),
                color: '4ba162',
                healthEffect: faker.animal.name(),
                note: faker.conference.name(),
                icon: faker.animal.name())));
  }
}
