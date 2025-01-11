import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:revolvair/app/app.setup.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:revolvair/generated/locale_keys.g.dart';

import 'helpers/navigate_to_air_quality_view.dart';

void main() async {

  await dotenv.load(fileName: ".env");
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  AppSetup.setupLocator();

  testWidgets("La page d'Échelles de qualité d'air doit être affichée", (tester) async {

    await navigateToAirQualityView(tester);

    final tabBarView = find.byType(TabBarView);
  
    expect(tabBarView, findsWidgets);
  });

   testWidgets("Les échelles de qualité de l'air de Revolvair doivent être affichées", (tester) async {

    await navigateToAirQualityView(tester);

    for (var i = 0; i < 6; i++) {

      var airQuality = find.byKey(Key('air_quality_$i'));

      expect(airQuality, findsOneWidget);
    }
  });

    testWidgets("Les échelles de qualité de l'air de AQHI-CANADA doivent être affichées", (tester) async {

    await navigateToAirQualityView(tester);

    final aqhiCanadaTabBar = find.byType(Tab);
    final aqhiCanadaTab = find.descendant(of: aqhiCanadaTabBar, matching: find.text(LocaleKeys.air_quality_tabs_aqhi_canada.tr()));

    await tester.tap(aqhiCanadaTab);

    await tester.pumpAndSettle();
    
    for (var i = 0; i < 10; i++) {

      var airQuality = find.byKey(Key('air_quality_$i'));

      expect(airQuality, findsOneWidget);
    }
  });

    testWidgets("Les échelles de qualité de l'air de IQA-USA doivent être affichées", (tester) async {

    await navigateToAirQualityView(tester);
    final iqaUsaTabBar = find.byType(Tab);

    final iqaUsaTab = find.descendant(of: iqaUsaTabBar, matching: find.text(LocaleKeys.air_quality_tabs_iqa_epa_us.tr()));
    await tester.tap(iqaUsaTab);

    await tester.pumpAndSettle();
    
    for (var i = 0; i < 6; i++) {

      var airQuality = find.byKey(Key('air_quality_$i'));

      expect(airQuality, findsOneWidget);
    }
  });
  testWidgets("La page de détail pour Revolvair doit être affichée", (tester) async {

    await navigateToAirQualityView(tester);

    final listTtile = find.byKey(const Key('air_quality_0'));

    await tester.tap(listTtile);

    await tester.pumpAndSettle();

    final label = find.text("Bon");

    await tester.pumpAndSettle(); 

    expect(label, findsWidgets);
  });

   testWidgets("La page de détail pour AQHI-CANADA doit être affichée", (tester) async {

    await navigateToAirQualityView(tester);

    final aqhiCanadaTabBar = find.byType(Tab);
    final aqhiCanadaTab = find.descendant(of: aqhiCanadaTabBar, matching: find.text("AQHI-Canada"));

    await tester.tap(aqhiCanadaTab);

    await tester.pumpAndSettle();

    final listTtile = find.byKey(const Key('air_quality_0'));

    await tester.tap(listTtile);

    await tester.pumpAndSettle();

    final label = find.text("1) Faible risque");

    await tester.pumpAndSettle(); 

    expect(label, findsWidgets);
  });

  testWidgets("La page de détail pour IQA EPA US doit être affichée", (tester) async {

    await navigateToAirQualityView(tester);

    final aqhiCanadaTabBar = find.byType(Tab);
    final aqhiCanadaTab = find.descendant(of: aqhiCanadaTabBar, matching: find.text("IQA EPA US"));

    await tester.tap(aqhiCanadaTab);

    await tester.pumpAndSettle();

    final listTtile = find.byKey(const Key('air_quality_0'));

    await tester.tap(listTtile);

    await tester.pumpAndSettle();

    final label = find.text("Bon");

    await tester.pumpAndSettle(); 

    expect(label, findsWidgets);
  });
  
}