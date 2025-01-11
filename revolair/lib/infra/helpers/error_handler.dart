import 'package:easy_localization/easy_localization.dart';
import 'package:revolvair/domain/failures/http_response_failure.dart';
import 'package:revolvair/domain/failures/invalid_cred_failure.dart';
import 'package:revolvair/domain/failures/network_failure.dart';
import 'package:revolvair/domain/failures/repository_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/generated/locale_keys.g.dart';

List<String> mapExceptionToMessage(Exception exception) {
  final List<String> messages = ["",""];
  if (exception is HttpResponseFailure) {
    messages[0] = LocaleKeys.errors_httpErrorsTitle.tr();
    messages[1] = LocaleKeys.errors_tryAgainMessage.tr();
    return messages;
  } else if (exception is NetworkFailure) {
    messages[0] = LocaleKeys.errors_networkErrorTitle.tr();
    messages[1] = LocaleKeys.errors_tryAgainMessage.tr();
    return messages;
  }else if(exception is RepositoryFailure){
    messages[0] = LocaleKeys.errors_repositoryErrorTitle.tr();
    messages[1] = LocaleKeys.errors_tryAgainMessage.tr();
    return messages;
  }else if(exception is UseCaseFailure){
    messages[0] = LocaleKeys.errors_useCaseErrorTitle.tr();
    messages[1] = LocaleKeys.errors_tryAgainMessage.tr();
    return messages;
  }else if(exception is InvalidCredFailure){
    messages[0] = "Erreur avec les identifiants.";
    messages[1] = "Email et/ou mot de passe invalide.";
    return messages;
  }
  else {
    messages[0] = LocaleKeys.errors_baseErrorTitle.tr();
    messages[1] = LocaleKeys.errors_tryAgainMessage.tr();
    return messages;
  }
}