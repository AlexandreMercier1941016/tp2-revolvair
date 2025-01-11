import 'package:easy_localization/easy_localization.dart';
import 'package:revolvair/domain/entities/measures_station/latest_measures_stations.dart';
import 'package:revolvair/domain/entities/measures_station/lives_measures_station.dart';
import 'package:revolvair/domain/entities/measures_station/station_infos.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';
import 'package:revolvair/infra/repositories/stations_measures_repository.dart';

class GetStationsMeasuresUseCase {
  final StationsMeasuresRepository stationsMeasuresRepository;
  GetStationsMeasuresUseCase({required this.stationsMeasuresRepository});

  Future<LivesMeasuresStation> executeStationsLiveMeasures(String slug) async {
    try {
      var response = await stationsMeasuresRepository.getStationsLiveMeasures(slug);
      return LivesMeasuresStation.fromJson(response);
    } on BaseFailure {
      rethrow;
    } catch (e) {
      throw UseCaseFailure(
          message: LocaleKeys.errors_useCaseErrorTitle.tr(),
          context: getExecutionContext());
    }
  }
  Future<LatestMeasuresStations> executeStationsLiveMeasures24h(String slug) async {
    try {
      var response = await stationsMeasuresRepository.getStationsLiveMeasures24h(slug);
      return LatestMeasuresStations.fromJson(response);
   } on BaseFailure {
      rethrow;
    } catch (e) {
      throw UseCaseFailure(
          message: LocaleKeys.errors_useCaseErrorTitle.tr(),
          context: getExecutionContext());
    }
  }

  Future<StationInfos> executeStationsInfos(String slug) async {
    try {
      var response = await stationsMeasuresRepository.getStationsInfos(slug);
      return StationInfos.fromJson(response);
   } on BaseFailure {
      rethrow;
    } catch (e) {
      throw UseCaseFailure(
          message: LocaleKeys.errors_useCaseErrorTitle.tr(),
          context: getExecutionContext());
    }
  }
  
}