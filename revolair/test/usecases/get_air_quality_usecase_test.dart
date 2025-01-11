import 'dart:convert';
import 'package:revolvair/domain/entities/air_quality/air_quality.dart';
import 'package:revolvair/domain/failures/http_response_failure.dart';
import 'package:revolvair/domain/failures/network_failure.dart';
import 'package:revolvair/domain/failures/repository_failure.dart';
import 'package:revolvair/domain/usecases/get_air_quality_use_case.dart';
import 'package:revolvair/infra/helpers/air_quality_index.dart';
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'package:revolvair/infra/repositories/air_quality_repository.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../fakers/revolvair_air_quality_faker.dart';

class HttpClientMock extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('GetAirQualityUseCase', () {
    late GetAirQualityUseCase getAirQualityUseCase;
    late HttpClientMock mockHttpClient;
    late AirQualityRepository airQualityRepository;
    setUp(() async {
      mockHttpClient = HttpClientMock();
      airQualityRepository = AirQualityRepository(httpClient: mockHttpClient);
      getAirQualityUseCase = GetAirQualityUseCase(repo: airQualityRepository);
      registerFallbackValue(FakeUri());
      await dotenv.load(fileName: ".env");
    });

    test(
        'Execute with Revolvair.org URL returns the expected JSON on a 200 status code',
        () async {
      // Arrange
      AirQuality expectedAirQuality = RevolvairAirQualityFaker().create();
      final httpResponse =
          http.Response(jsonEncode(expectedAirQuality.toJson()), 200);
      String url = revolvairUrl;
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => Future.value(httpResponse));
      // Act
      final result =
          await getAirQualityUseCase.execute(AirQualityIndex.revolvair);
      // Assert
      expect(result, expectedAirQuality);
    });
    test(
        'Execute with AQHI CANADA URL returns the expected JSON on a 200 status code',
        () async {
      // Arrange
      AirQuality expectedAirQuality = RevolvairAirQualityFaker().create();
      final httpResponse =
          http.Response(jsonEncode(expectedAirQuality.toJson()), 200);
      String url = canadaUrl;
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => Future.value(httpResponse));
      // Act
      final result =
          await getAirQualityUseCase.execute(AirQualityIndex.canada);
      // Assert
      expect(result, expectedAirQuality);
    });
    test(
        'Execute with IQA EPA US URL returns the expected JSON on a 200 status code',
        () async {
      // Arrange
      AirQuality expectedAirQuality = RevolvairAirQualityFaker().create();
      final httpResponse =
          http.Response(jsonEncode(expectedAirQuality.toJson()), 200);
      String url = iqaEpaUs;
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => Future.value(httpResponse));
      // Act
      final result =
          await getAirQualityUseCase.execute(AirQualityIndex.epaUs);
      // Assert
      expect(result, expectedAirQuality);
    });
    test(
        'Execute with Revolvair.org throws HttpException on a 404 status code on',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Not Found', 404)));

      // Act & Assert
      expect(
        () async =>
            await getAirQualityUseCase.execute(AirQualityIndex.revolvair),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute with Revolvair.org throws HttpException on a 500 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Server error', 500)));

      // Act & Assert
      expect(
        () async =>
            await getAirQualityUseCase.execute(AirQualityIndex.revolvair),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute with Revolvair.org throws a NetworkFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(NetworkFailure());
      // Assert
      expect(
          () async =>
              await getAirQualityUseCase.execute(AirQualityIndex.revolvair),
          throwsA(isA<NetworkFailure>()));
    });
    test('Execute with Revolvair.org throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getAirQualityUseCase.execute(AirQualityIndex.revolvair),
          throwsA(isA<RepositoryFailure>()));
    });

    test('Execute with AQHI CANADA throws HttpException on a 404 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Not Found', 404)));

      // Act & Assert
      expect(
        () async =>
            await getAirQualityUseCase.execute(AirQualityIndex.canada),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute with AQHI CANADA throws HttpException on a 500 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Server error', 500)));

      // Act & Assert
      expect(
        () async =>
            await getAirQualityUseCase.execute(AirQualityIndex.canada),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute with AQHI CANADA throws NetworkFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(NetworkFailure());
      // Assert
      expect(
          () async =>
              await getAirQualityUseCase.execute(AirQualityIndex.canada),
          throwsA(isA<NetworkFailure>()));
    });
    test('Execute with AQHI CANADA throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getAirQualityUseCase.execute(AirQualityIndex.canada),
          throwsA(isA<RepositoryFailure>()));
    });
    test('Execute with IQA EPA US throws HttpException on a 404 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Not Found', 404)));

      // Act & Assert
      expect(
        () async =>
            await getAirQualityUseCase.execute(AirQualityIndex.epaUs),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute with IQA EPA US throws HttpException on a 500 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Server error', 500)));

      // Act & Assert
      expect(
        () async =>
            await getAirQualityUseCase.execute(AirQualityIndex.epaUs),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute with IQA EPA US throws a NetworkFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(NetworkFailure());
      // Assert
      expect(
          () async =>
              await getAirQualityUseCase.execute(AirQualityIndex.epaUs),
          throwsA(isA<NetworkFailure>()));
    });
    test('Execute with IQA EPA US throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getAirQualityUseCase.execute(AirQualityIndex.epaUs),
          throwsA(isA<RepositoryFailure>()));
    });
  });
}
