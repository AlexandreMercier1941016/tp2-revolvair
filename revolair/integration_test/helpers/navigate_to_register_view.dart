import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revolvair/presentation/main.dart';

Future<void> navigateToRegisteryView(WidgetTester tester) async {

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

final connectionText = find.text("Connexion");
    //final connectionText = find.text(LocaleKeys.connection_title.tr());
    await tester.tap(connectionText);

    await tester.pumpAndSettle();

    final noAccountText = find.widgetWithText(TextButton,"Je n'ai pas de compte");
    await tester.tap(noAccountText);

    await tester.pumpAndSettle();
  }