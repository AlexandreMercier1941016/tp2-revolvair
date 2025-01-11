import 'package:flutter/material.dart';
import 'package:revolvair/app/app.router.dart';
import 'package:revolvair/app/app.setup.dart';
import 'package:revolvair/domain/failures/invalid_cred_failure.dart';
import 'package:revolvair/domain/usecases/login_use_case.dart';
import 'package:revolvair/infra/helpers/error_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final LoginUseCase _loginUseCase = locator<LoginUseCase>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    setBusy(true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _dialogService.showDialog(
        title: 'Entrée invalide',
        description: 'Veuillez remplir tous les champs.',
        buttonTitle: 'OK',
      );
      setBusy(false);
      return;
    }

    try {
      await _loginUseCase.execute(email, password);

      navigateToHomePage();
    } on InvalidCredFailure {
      _dialogService.showDialog(
        title: mapExceptionToMessage(InvalidCredFailure())[0],
        description: mapExceptionToMessage(InvalidCredFailure())[1],
        buttonTitle: 'OK',
      );
    }
    
    catch (e) {
      _dialogService.showDialog(
        title: "Une erreur est survenue.",
        description: "Veuillez réessayer plus tard.",
        buttonTitle: 'OK',
      );
      //showPersonalizedDialog(_dialogService, mapExceptionToMessage(error(e))[0],mapExceptionToMessage(error(e))[1]);
    } finally {
      setBusy(false);
    }
  }

  void navigateToHomePage() {
    _navigationService.replaceWith(Routes.homeView);
  }

  void navigateToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }
}
