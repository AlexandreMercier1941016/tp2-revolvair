import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:revolvair/app/app.setup.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/presentation/views/map/map_view.dart';

import 'helpers/navigate_to_air_quality_view.dart';
import 'helpers/navigate_to_register_view.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  AppSetup.setupLocator();
  testWidgets("Je peux naviguer a la page de creation de compte.",
      (tester) async {
    await navigateToRegisteryView(tester);

    final inscriptionText = find.text("Inscription");

    expect(inscriptionText, findsWidgets);
  });

  testWidgets(
      "Je peux naviguer a la page de creation de compte et ecrire dans le champ ",
      (tester) async {
    await navigateToRegisteryView(tester);
    final expectedName = "Alexandre";

    final nameText = find.widgetWithText(TextField, "Nom");
    await tester.enterText(nameText, expectedName);

    await tester.pumpAndSettle();

    final textField = tester.widget<TextField>(nameText);
    final controller = textField.controller;

    expect(controller?.text, expectedName);
  });

  testWidgets(
      "Je peux naviguer a la page de creation de compte et ecrire dans le courriel ",
      (tester) async {
    await navigateToRegisteryView(tester);
    final expectedEmail = "test@test.test";

    final emailText = find.widgetWithText(TextField, "Courriel");
    await tester.enterText(emailText, expectedEmail);

    await tester.pumpAndSettle();

    final textField = tester.widget<TextField>(emailText);
    final controller = textField.controller;

    expect(controller?.text, expectedEmail);
  });
  testWidgets(
      "Je peux naviguer a la page de creation de compte et ecrire dans le mot de passe ",
      (tester) async {
    await navigateToRegisteryView(tester);
    final expectedPassword = "tigerlover";

    final passwordText = find.widgetWithText(TextField, "Mot de passe");
    await tester.enterText(passwordText, expectedPassword);

    await tester.pumpAndSettle();

    final textField = tester.widget<TextField>(passwordText);
    final controller = textField.controller;

    expect(controller?.text, expectedPassword);
  });
  testWidgets(
      "Je peux naviguer a la page de creation de compte et ecrire dans le confirmer le mot de passe ",
      (tester) async {
    await navigateToRegisteryView(tester);
    final expectedSecondPassword = "tigerlover";

    final secondPasswordText =
        find.widgetWithText(TextField, "Confirmer le mot de passe");
    await tester.enterText(secondPasswordText, expectedSecondPassword);

    await tester.pumpAndSettle();

    final textField = tester.widget<TextField>(secondPasswordText);
    final controller = textField.controller;

    expect(controller?.text, expectedSecondPassword);
  });

  testWidgets(
      "Je peux naviguer a la page de creation de compte et cocher la case des termes ",
      (tester) async {
    await navigateToRegisteryView(tester);

    final checkbox = find.byType(Checkbox);
    await tester.tap(checkbox);

    await tester.pumpAndSettle(); 

    final checkbox1 = tester.widget<Checkbox>(checkbox);

    expect(checkbox1.value, isTrue);
  });

  testWidgets(
      "Je peux naviguer a la page de creation de compte et cliquer sur le bouton creer le compte et etre redirige vers la home page.",
      (tester) async {
    await navigateToRegisteryView(tester);

    final expectedName = "Alexandre";

    final nameText = find.widgetWithText(TextField, "Nom");
    await tester.enterText(nameText, expectedName);

    await tester.pumpAndSettle();

    //Pour éviter d'avoir l'erreur qui dit que l'email existe déjà
    var randomEmail = "${Faker().color.color().replaceAll(' ', '')}@${Faker().color.color().replaceAll(' ', '')}.${Faker().color.color().replaceAll(' ', '')}";
    final expectedEmail = randomEmail;

    final emailText = find.widgetWithText(TextField, "Courriel");
    await tester.enterText(emailText, expectedEmail);

    await tester.pumpAndSettle();

    final expectedPassword = "tigerlover";

    final passwordText = find.widgetWithText(TextField, "Mot de passe");
    await tester.enterText(passwordText, expectedPassword);

    await tester.pumpAndSettle();

    final expectedSecondPassword = "tigerlover";

    final secondPasswordText =
        find.widgetWithText(TextField, "Confirmer le mot de passe");
    await tester.enterText(secondPasswordText, expectedSecondPassword);

    await tester.pumpAndSettle();

    final checkbox = find.byType(Checkbox);
    await tester.tap(checkbox);

    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.tap(button);

    await tester.pumpAndSettle();

    final currentView = find.byType(MapView);

    expect(currentView, findsOneWidget);
  });
}
