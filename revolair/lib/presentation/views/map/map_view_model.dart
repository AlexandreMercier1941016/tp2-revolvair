import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:revolvair/app/app.router.dart';
import 'package:revolvair/app/app.setup.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality_range.dart';
import 'package:revolvair/domain/entities/stations/latest_stations.dart';
import 'package:revolvair/domain/entities/stations/stations.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/domain/usecases/get_air_quality_use_case.dart';
import 'package:revolvair/domain/usecases/get_stations_use_case.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/air_quality_index.dart';
import 'package:revolvair/infra/helpers/showDialog.dart';
import 'package:revolvair/presentation/helpers/color_to_hex.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MapViewModel extends BaseViewModel { 
final _getStationsUseCase = locator<GetStationsUseCase>();
  final _getAirQualityUseCase = locator<GetAirQualityUseCase>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final MapController mapController = MapController();
  static const LatLng defaultLatLng = LatLng(46.78667, -71.28694);
  LatLng currentLatLng = defaultLatLng;

  bool isCentered = true;
  bool locationEnabled = true;
  bool positionFound = true;

  LatestStations latestStations = LatestStations(latestStations: List.empty());
  Stations stations = Stations(stations: List.empty());
  LatestStations updatedStations = LatestStations(latestStations: []);
  List<AirQualityRange> ranges = List.empty();

  Future<void> getLatestStations() async {
    setBusy(true);
    try {
      var response = await _getStationsUseCase.executeLatestStations();
      latestStations = response;
    } on BaseFailure catch (e) {
      showPersonalizedDialog(
          _dialogService, e.message, LocaleKeys.errors_dialogErrorMessage.tr());
    } on UseCaseFailure catch (e) {
      showPersonalizedDialog(
          _dialogService, e.message, LocaleKeys.errors_dialogErrorMessage.tr());
    } finally {
      setBusy(false);
    }
  }

  Future<void> getStations() async {
    setBusy(true);
    try {
      var response = await _getStationsUseCase.executeStations();
      stations = response;
    } on BaseFailure catch (e) {
      showPersonalizedDialog(
          _dialogService, e.message, LocaleKeys.errors_dialogErrorMessage.tr());
    } on UseCaseFailure catch (e) {
      showPersonalizedDialog(
          _dialogService, e.message, LocaleKeys.errors_dialogErrorMessage.tr());
    } finally {
      setBusy(false);
    }
  }

  Future<void> getAllActiveStations() async {
    setBusy(true);
    await getStations();
    await getLatestStations();
    for (var latestStation in latestStations.latestStations) {
      for (var station in stations.stations) {
        if (station.id == latestStation.stationId) {
          updatedStations.latestStations.add(latestStation);
        }
      }
    }
  }
  Future<void> initLocation() async {
    setBusy(true);
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      locationEnabled = false;
      positionFound = false;
      setBusy(false);
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      currentLatLng = LatLng(position.latitude, position.longitude);
      isCentered = true;
      positionFound = true;

      mapController.move(currentLatLng, 15.5);
    } catch (e) {
      currentLatLng = defaultLatLng;
      isCentered = true;
      positionFound = false;

      mapController.move(defaultLatLng, 15.5);
    }

    setBusy(false);
  }

  Future<void> setAirQualityRanges() async {
    setBusy(true);
    var airQuality =
        await _getAirQualityUseCase.execute(AirQualityIndex.revolvair);
    ranges = airQuality.ranges;
    setBusy(false);
  }

  Future<void> updateLatestStations() async {
    setBusy(true);
    for (var station in stations.stations) {
      for (var updatedStation in updatedStations.latestStations) {
        if (updatedStation.stationId == station.id) {
          station.color =
              await getColorFromAirQualityRange(updatedStation.value);
        }
      }
      setBusy(false);
    }
  }

  Future<Color> getColorFromAirQualityRange(String value) async {
    setBusy(true);
    Color defaultColor = Colors.grey;
    final airQualityValue = double.tryParse(value);
    if (airQualityValue == null) {
      return defaultColor;
    }
    for (AirQualityRange range in ranges) {
      if (airQualityValue >= range.min && airQualityValue <= range.max) {
        defaultColor = getColorFromHex(range.color);
        break;
      }
    }
    setBusy(false);
    return defaultColor;
  }
  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void recenterMap() {
    mapController.move(currentLatLng, 15.5);
    isCentered = true;
    notifyListeners();
  }

  void setNotCentered() {
    if (isCentered) {
      isCentered = false;
      notifyListeners();
    }
  }

  void navigateToStation(String slug, Color color) {
    _navigationService.navigateTo(Routes.stationView,arguments: StationViewArguments(slug: slug, color: color));
  }
}


  