import 'package:easy_localization/easy_localization.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> showPersonalizedDialog(
    DialogService dialogService, String title, String description) async {
  await dialogService.showDialog(
    title: title,
    description: description,
    buttonTitle: LocaleKeys.errors_dialogErrorButton.tr(),
  );
}
