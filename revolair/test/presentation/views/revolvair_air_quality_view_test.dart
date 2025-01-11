import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality.dart';
import 'package:revolvair/domain/usecases/get_air_quality_use_case.dart';
import 'package:revolvair/infra/helpers/air_quality_index.dart';
import 'package:revolvair/presentation/views/revolvair_air_quality/revolvair_air_quality_view.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../fakers/revolvair_air_quality_faker.dart';

class MockDialogService extends Mock implements DialogService {}

class MockGetAirQualityUseCase extends Mock implements GetAirQualityUseCase {}

class MockSnackbarService extends Mock implements SnackbarService {}

class MockNavigationService extends Mock implements NavigationService {}

//class MockStackedService extends Mock implements StackedService {}

final locator = GetIt.instance;

void main() {
  group('RevolvairAirQualityView Widget Test', () {
    late MockDialogService mockDialogService;
    late MockGetAirQualityUseCase mockGetAirQualityUseCase;
    late MockSnackbarService mockSnackBarService;
    late MockNavigationService mockNavigationService;
    //late MockStackedService mockStackedService;

    setUp(() async {
      await dotenv.load(fileName: ".env");
      locator.reset();
      mockDialogService = MockDialogService();
      mockGetAirQualityUseCase = MockGetAirQualityUseCase();
      mockSnackBarService = MockSnackbarService();
      mockNavigationService = MockNavigationService();

      locator.registerLazySingleton<DialogService>(() => mockDialogService);
      locator.registerLazySingleton<SnackbarService>(() => mockSnackBarService);
      locator.registerLazySingleton<GetAirQualityUseCase>(() => mockGetAirQualityUseCase);
      locator.registerLazySingleton<NavigationService>(() => mockNavigationService);
    });

    testWidgets(
        'Une barre circulaire de chargement est affichée au chargement de la liste',
        (WidgetTester tester) async {
      final Future<AirQuality> airQuality = Future.value(RevolvairAirQualityFaker().create());
      when(() => mockGetAirQualityUseCase.execute(AirQualityIndex.revolvair)).thenAnswer((_) async => airQuality);
      // On construit le widget qui sera testé
      await tester.pumpWidget(
        const MaterialApp(
          home: RevolvairAirQualityView(apiRoute: AirQualityIndex.revolvair),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('RevolvairAirQualityView affiche la liste',
        (WidgetTester tester) async {
      final Future<AirQuality> airQuality = Future.value(RevolvairAirQualityFaker().create());
      when(() => mockGetAirQualityUseCase.execute(AirQualityIndex.revolvair))
          .thenAnswer((_) async => airQuality);
      await tester.pumpWidget(
        const MaterialApp(
          home: RevolvairAirQualityView(apiRoute: AirQualityIndex.revolvair)
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNWidgets(3));
    });
  });
}
