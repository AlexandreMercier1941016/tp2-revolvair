import 'package:easy_localization/easy_localization.dart';
import 'package:revolvair/domain/entities/stations/latest_stations.dart';
import 'package:revolvair/domain/entities/stations/stations.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';
import 'package:revolvair/infra/repositories/stations_repository.dart';

class GetStationsUseCase {
  final StationsRepository stationsRepository;
  GetStationsUseCase({required this.stationsRepository});

   Future<LatestStations> executeLatestStations() async {
    try {
      var response = await stationsRepository.getLatestStationsFromRevolvair();
      return LatestStations.fromJson(response);
    } on BaseFailure {
      rethrow;
    } catch (e) {
      throw UseCaseFailure(
          message: LocaleKeys.errors_useCaseErrorTitle.tr(),
          context: getExecutionContext());
    }
  }
   Future<Stations> executeStations() async {
    try {
      var response = await stationsRepository.getStationsFromRevolvair();
      return Stations.fromJson(response);
    } on BaseFailure {
      rethrow;
    } catch (e) {
      throw UseCaseFailure(
          message: LocaleKeys.errors_useCaseErrorTitle.tr(),
          context: getExecutionContext());
    }
  }
}