import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revolvair/app/app.router.dart';
import 'package:revolvair/domain/usecases/get_user_use_case.dart';
import 'package:revolvair/presentation/views/register/register_view.dart';
import 'package:stacked_services/stacked_services.dart';

class MockDialogService extends Mock implements DialogService {}

class MockRegisterUseCase extends Mock implements GetUserUseCase {}

class MockSnackbarService extends Mock implements SnackbarService {}

class MockNavigationService extends Mock implements NavigationService {}

final locator = GetIt.instance;

void main() {
  group('LoginView Widget Test', () {
    late MockDialogService mockDialogService;
    late MockRegisterUseCase mockRegisterUseCase;
    late MockSnackbarService mockSnackBarService;
    late MockNavigationService mockNavigationService;

    setUp(() async {
      await dotenv.load(fileName: ".env");
      locator.reset();
      mockDialogService = MockDialogService();
      mockRegisterUseCase = MockRegisterUseCase();
      mockSnackBarService = MockSnackbarService();
      mockNavigationService = MockNavigationService();
      locator.registerLazySingleton<DialogService>(() => mockDialogService);
      locator.registerLazySingleton<SnackbarService>(() => mockSnackBarService);
      locator.registerLazySingleton<GetUserUseCase>(() => mockRegisterUseCase);
      locator.registerLazySingleton<NavigationService>(
          () => mockNavigationService);
    });

    testWidgets('Les champs du formulaire sont affichés',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterView(),
        ),
      );

      final nameField = find.widgetWithText(TextField, 'Nom');
      expect(nameField, findsOneWidget);
      final emailField = find.widgetWithText(TextField, 'Courriel');
      expect(emailField, findsOneWidget);
      final passwordField = find.widgetWithText(TextField, 'Mot de passe');
      expect(passwordField, findsOneWidget);
      final confirmPasswordField =
          find.widgetWithText(TextField, 'Confirmer le mot de passe');
      expect(confirmPasswordField, findsOneWidget);
      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);
    });
    testWidgets('Les champs du formulaire change lors de changements',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterView(),
        ),
      );
      final nameField = find.widgetWithText(TextField, 'Nom');
      final emailField = find.widgetWithText(TextField, 'Courriel');
      final passwordField = find.widgetWithText(TextField, 'Mot de passe');
      final confirmPasswordField =
          find.widgetWithText(TextField, 'Confirmer le mot de passe');
      final checkboxFinder = find.byType(Checkbox);

      const name = "test";
      const email = "test@gmail.com";
      const password = "admin";
      const confirmPassword = "admin2";
      await tester.enterText(nameField, name);
      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      await tester.enterText(confirmPasswordField, confirmPassword);
      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();
      final checkbox = tester.widget<Checkbox>(checkboxFinder);

      expect(find.text(name), findsOneWidget);
      expect(find.text(email), findsOneWidget);
      expect(find.text(password), findsOneWidget);
      expect(find.text(confirmPassword), findsOneWidget);
      expect(checkbox.value, isTrue);
    });
    testWidgets(
        "Un message d'erreur est affiché dans la page creation de compte",
        (WidgetTester tester) async {
      when(() => mockDialogService.showDialog(
            title: any(named: 'title'),
            description: any(named: 'description'),
            buttonTitle: any(named: 'buttonTitle'),
          )).thenAnswer((_) async => null);

      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterView(),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);

      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();

      final registerButton =
          find.widgetWithText(ElevatedButton, 'Créer le compte');
      await tester.tap(registerButton);

      await tester.pumpAndSettle();

      verify(() => mockDialogService.showDialog(
            title: any(named: 'title'),
            description: any(named: 'description'),
            buttonTitle: any(named: 'buttonTitle'),
          )).called(1);
    });
    testWidgets(
      "SnackBar apparaît lorsque les deux mots de passe sont différents",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: RegisterView(),
          ),
        );

        final nameField = find.widgetWithText(TextField, 'Nom');
        final emailField = find.widgetWithText(TextField, 'Courriel');
        final passwordField = find.widgetWithText(TextField, 'Mot de passe');
        final confirmPasswordField =
            find.widgetWithText(TextField, 'Confirmer le mot de passe');
        final checkboxFinder = find.byType(Checkbox);

        const name = "test";
        const email = "test@gmail.com";
        const password = "admin";
        const confirmPassword = "admin2";

        await tester.enterText(nameField, name);
        await tester.enterText(emailField, email);
        await tester.enterText(passwordField, password);
        await tester.enterText(confirmPasswordField, confirmPassword);
        await tester.tap(checkboxFinder);
        await tester.pumpAndSettle();

        final registerButton =
            find.widgetWithText(ElevatedButton, 'Créer le compte');
        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        expect(find.text('Les mots de passe ne correspondent pas.'),
            findsOneWidget);
      },
    );
    testWidgets(
        "L'utilisateur est redirigé vers la HomeView après un enregistrement réussi",
        (WidgetTester tester) async {
      const name = "test";
      const email = "test@gmail.com";
      const password = "admin123";
      const confirmPassword = "admin123";
      final testUserData = {
        "name": name,
        "email": email,
        "password": password,
      };
      when(() => mockRegisterUseCase.executeCreateUser(testUserData))
          .thenAnswer((_) async => {"success": true});
      when(() => mockNavigationService.replaceWith(
            Routes.homeView,
            arguments: any(named: 'arguments'),
          )).thenAnswer((_) async {});
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterView(),
        ),
      );
      final nameField = find.widgetWithText(TextField, 'Nom');
      final emailField = find.widgetWithText(TextField, 'Courriel');
      final passwordField = find.widgetWithText(TextField, 'Mot de passe');
      final confirmPasswordField =
          find.widgetWithText(TextField, 'Confirmer le mot de passe');
      final checkboxFinder = find.byType(Checkbox);

      await tester.enterText(nameField, name);
      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      await tester.enterText(confirmPasswordField, confirmPassword);
      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();

      final registerButton =
          find.widgetWithText(ElevatedButton, 'Créer le compte');
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

verify(() => mockNavigationService.navigateTo(
      Routes.homeView,
      arguments: any(named: 'arguments'),
    )).called(1);

    });
  });
}
