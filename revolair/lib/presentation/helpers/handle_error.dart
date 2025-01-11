import 'package:revolvair/app/app.setup.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:revolvair/presentation/helpers/registerErrorSnackbar.dart';

void handleError(dynamic error) {
  final snackBarService = locator<SnackbarService>();

  // Si le projet contient des erreurs personnalisées, comme des "failures", il faudrait les gérer ici. Par exemple:
  // if (error is BaseFailure) {
  //    ... afficher le message d'erreur de la Failure ...
  // else {
  //    ... afficher un message d'erreur qui concerne toutes les erreurs qui n'ont pas été gérées avant ...
  // }

  //Ici l'erreur est affichée dans un snackbar,mais on pourrait aussi afficher une boîte de dialogue.
  //À noter que le snackbar utilise la configuration de SnackbarType.alert définie dans registerErrorSnackbar.dart, initialisée dans main.dart.
  snackBarService.showCustomSnackBar(
    variant: SnackbarType.alert,
    title: 'Erreur',
    message:
        "Une erreur s'est produite. Si le problème persiste, veuillez contacter le support.",
    duration: const Duration(seconds: 5),
  );
}