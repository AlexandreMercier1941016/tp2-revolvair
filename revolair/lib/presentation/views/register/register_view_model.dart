import 'package:easy_localization/easy_localization.dart';
import 'package:revolvair/app/app.router.dart';
import 'package:revolvair/app/app.setup.dart';
import 'package:revolvair/domain/failures/base_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/domain/usecases/get_user_use_case.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/showDialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel{
final _navigationService = locator<NavigationService>();
final _dialogService = locator<DialogService>();
final GetUserUseCase _getUserUseCase = 
    locator<GetUserUseCase>();

void navigateToHomePage() {
    _navigationService.navigateTo(Routes.homeView);
  }
//jkafdjdfghkdsf
Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if(name.isEmpty || email.isEmpty || password.isEmpty){
      showPersonalizedDialog(_dialogService, "Veuillez remplir tous les champs",
          "Veuillez remplir tous les champs");
      return;
    }
    setBusy(true);
    try{
     await _getUserUseCase.executeCreateUser({'name': name,'email': email,'password': password});

      navigateToHomePage();
    }
     on BaseFailure catch (e) {
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
}