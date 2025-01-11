import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/presentation/main.dart'; 
 
 Future<void> navigateToAirQualityView(WidgetTester tester) async {

  await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('fr', 'CA')],
        path: 'assets/translations',
        startLocale: const Locale('fr', 'CA'),
        child: const MainApp(),
      ),
    );
    

    await tester.pumpAndSettle();

    final drawerIcon = find.byIcon(Icons.menu);
    await tester.tap(drawerIcon);

    await tester.pumpAndSettle();

    final airQualityText = find.text(LocaleKeys.air_quality_title.tr());
    await tester.tap(airQualityText);

    await tester.pumpAndSettle();
  }