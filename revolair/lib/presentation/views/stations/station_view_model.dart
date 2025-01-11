import 'package:revolvair/app/app.setup.dart';
import 'package:revolvair/domain/entities/measures_station/latest_measures_stations.dart';
import 'package:revolvair/domain/entities/measures_station/lives_measures_station.dart';
import 'package:revolvair/domain/entities/measures_station/station_infos.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/usecases/get_stations_measures_use_case.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
class StationViewModel  extends BaseViewModel{
  final getStationsMeasuresUseCase = locator<GetStationsMeasuresUseCase>();
  final _dialogService = locator<DialogService>();
  
  LivesMeasuresStation livesMeasuresStation = LivesMeasuresStation.empty();
  LatestMeasuresStations latestMeasuresStation = LatestMeasuresStations.empty();
  StationInfos stationInfos = StationInfos.empty();
  

  Future<void> getLivesMeasuresStation(String slug) async {
    setBusy(true);
    try {
      livesMeasuresStation = await getStationsMeasuresUseCase.executeStationsLiveMeasures(slug);

    } on BaseFailure catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    } finally {
      notifyListeners();
      setBusy(false);
    }
  }
  Future<void> getLatestMeasuresStation(String slug) async {
    setBusy(true);
    try {
      latestMeasuresStation = await getStationsMeasuresUseCase.executeStationsLiveMeasures24h(slug);
    } on BaseFailure catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    } finally {
      notifyListeners();
      setBusy(false);
    }
  }
  Future<void> getStationInfos(String slug) async {
    setBusy(true);
    try {
      stationInfos = await getStationsMeasuresUseCase.executeStationsInfos(slug);
    } on BaseFailure catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    } finally {
      notifyListeners();
      setBusy(false);
    }
  }
}