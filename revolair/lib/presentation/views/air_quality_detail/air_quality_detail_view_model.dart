import 'package:revolvair/app/app.setup.dart';
import 'package:revolvair/infra/helpers/error_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:revolvair/infra/helpers/showDialog.dart';

class AirQualityDetailViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  void redirectToWebPage(String url) async {
    try {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } 
    } catch (e) {
      showPersonalizedDialog(_dialogService, mapExceptionToMessage(error(e))[0],mapExceptionToMessage(error(e))[1]);
    }
  }
}
