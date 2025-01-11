import 'package:revolvair/app/app.setup.dart';
import 'package:revolvair/domain/usecases/load_session_use_case.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:revolvair/app/app.router.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _loadSessionUseCase = locator<LoadSessionUseCase>();

  void navigateToHomePage() {
    _navigationService.navigateTo(Routes.homeView);
  }

  void navigateToAirQuality() {
    _navigationService.navigateTo(Routes.airQualityView);
  }

  void navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  Future<bool> isLoggedIn() async {
    if (await _loadSessionUseCase.executeGetToken() != "" &&
        await _loadSessionUseCase.executeGetToken() != null) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<String> getTextByState() async {
    if (await isLoggedIn()) {
      return "Deconnexion";
    } else {
      return "Connexion";
    }
  }

  Future<void> onTapByState() async {
    if (await isLoggedIn()) {
      deconnect();
    } else {
      navigateToLogin();
    }
  }

  void deconnect() {
    _loadSessionUseCase.executeDeleteToken();
  }
}
