import 'package:easy_localization/easy_localization.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/air_quality_index.dart';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';
import 'package:revolvair/infra/repositories/air_quality_repository.dart';
class GetAirQualityUseCase {
  final AirQualityRepository repo;
  GetAirQualityUseCase({required this.repo});

  Future<AirQuality> execute(AirQualityIndex apiRoute) async {
    try {
      var response = await repo.getRevolairAirQuality(apiRoute);
      return AirQuality.fromJson(response);
    } on BaseFailure {
      rethrow;
    } catch (e) {
      throw UseCaseFailure(
          message: LocaleKeys.errors_useCaseErrorTitle.tr(),
          context: getExecutionContext());
    }
  }
}
