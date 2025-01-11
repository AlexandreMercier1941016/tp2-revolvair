import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revolvair/app/app.router.dart';
import 'package:revolvair/domain/usecases/login_use_case.dart';
import 'package:revolvair/presentation/views/login/login_view.dart';
import 'package:stacked_services/stacked_services.dart';

class MockDialogService extends Mock implements DialogService {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockSnackbarService extends Mock implements SnackbarService {}

class MockNavigationService extends Mock implements NavigationService {}

final locator = GetIt.instance;

void main() {
  group('LoginView Widget Test', () {
    late MockDialogService mockDialogService;
    late MockLoginUseCase mockLoginUseCase;
    late MockSnackbarService mockSnackBarService;
    late MockNavigationService mockNavigationService;
    //late MockStackedService mockStackedService;

    setUp(() async {
      await dotenv.load(fileName: ".env");
      locator.reset();
      mockDialogService = MockDialogService();
      mockLoginUseCase = MockLoginUseCase();
      mockSnackBarService = MockSnackbarService();
      mockNavigationService = MockNavigationService();

      locator.registerLazySingleton<DialogService>(() => mockDialogService);
      locator.registerLazySingleton<SnackbarService>(() => mockSnackBarService);
      locator.registerLazySingleton<LoginUseCase>(() => mockLoginUseCase);
      locator.registerLazySingleton<NavigationService>(() => mockNavigationService);
    });

    testWidgets(
        'Les champs du formulaire sont affichés',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginView(),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Courriel');
      expect(emailField, findsOneWidget);

      final passwordField = find.widgetWithText(TextField, 'Mot de passe');
      expect(passwordField, findsOneWidget);
    });
     testWidgets(
        'Les champs du formulaire change lors de changements',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginView(),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Courriel');
      final passwordField = find.widgetWithText(TextField, 'Mot de passe');
      const email = "test@gmail.com";
      const password = "admin";

      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);

      expect(find.text(email), findsOneWidget);
      expect(find.text(password), findsOneWidget);
    });
    testWidgets(
        "Un message d'erreur est affiché dans la page connection",
        (WidgetTester tester) async {
        const email = "test@gmail.com";
        const password = "admin";
        when(() => mockDialogService.showDialog(
            title: any(named: 'title'),
            description: any(named: 'description'),
            buttonTitle: any(named: 'buttonTitle'),
          )).thenAnswer((_) async => null);

      await tester.pumpWidget(
        const MaterialApp(
          home: LoginView(),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Courriel');
      final passwordField = find.widgetWithText(TextField, 'Mot de passe');

      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      
      final loginButton = find.widgetWithText(ElevatedButton, 'Connexion');
      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      verify(() => mockDialogService.showDialog(
          title: any(named: 'title'),
          description: any(named: 'description'),
          buttonTitle: any(named: 'buttonTitle'),
        )).called(1);
    });
        testWidgets(
        "L'utilisateur est redirigé vers la HomeView",
        (WidgetTester tester) async {
        const email = "test@gmail.com";
        const password = "admin";
        when(() => mockLoginUseCase.execute(email, password)).thenAnswer((_) async => {});
         when(() => mockNavigationService.replaceWith(Routes.homeView, arguments: any(named: 'arguments'))).thenAnswer((_) async => {});

      await tester.pumpWidget(
        const MaterialApp(
          home: LoginView(),
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Courriel');
      final passwordField = find.widgetWithText(TextField, 'Mot de passe');

      await tester.enterText(emailField, email);
      await tester.enterText(passwordField, password);
      
      final loginButton = find.widgetWithText(ElevatedButton, 'Connexion');
      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      verify(() => mockNavigationService.replaceWith(Routes.homeView, arguments: any(named: 'arguments'))).called(1);
    });
  });
}
