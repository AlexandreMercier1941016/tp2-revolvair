import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:revolvair/app/app.router.dart';
import 'package:revolvair/app/app.setup.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await AppSetup.setupLocator();
  runApp(EasyLocalization(
        supportedLocales: const [Locale('fr', 'CA')], 
        path: 'assets/translations',
        fallbackLocale: const Locale('fr', 'CA'), 
        child: const MainApp()),);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates, 
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: Routes.homeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
