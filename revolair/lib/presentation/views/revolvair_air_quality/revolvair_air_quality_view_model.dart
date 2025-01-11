import 'package:revolvair/app/app.router.dart';
import 'package:revolvair/app/app.setup.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality_range.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/domain/usecases/get_air_quality_use_case.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/air_quality_index.dart';
import 'package:revolvair/infra/helpers/showDialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:easy_localization/easy_localization.dart';

class RevolvairAirQualityViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final GetAirQualityUseCase _getAirQualityUseCase =
      locator<GetAirQualityUseCase>();
  AirQuality airQuality = AirQuality.empty();

  Future<void> getRevolvairAirQualityFromRepository(
      AirQualityIndex apiRoute) async {
    setBusy(true);
    try {
      var response = await _getAirQualityUseCase.execute(apiRoute);
      airQuality = response;
    } on BaseFailure catch (e) {
      showPersonalizedDialog(_dialogService, e.message,
          LocaleKeys.errors_dialogErrorMessage.tr());
    } on UseCaseFailure catch (e) {
      showPersonalizedDialog(_dialogService, e.message,//Pt changer le e.message pour la traaduction
          LocaleKeys.errors_dialogErrorMessage.tr());
    } finally {
      notifyListeners();
      setBusy(false);
    }
  }

  void navigateToDetail(
      AirQualityRange range, String source,String url) {
    _navigationService.navigateTo(Routes.airQualityDetailView,
        arguments: AirQualityDetailViewArguments(
            range: range,source : source, url: url));
  }
}
