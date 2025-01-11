import 'dart:convert';
import 'package:revolvair/domain/entities/stations/latest_stations.dart';
import 'package:revolvair/domain/entities/stations/stations.dart';
import 'package:revolvair/domain/failures/http_response_failure.dart';
import 'package:revolvair/domain/failures/network_failure.dart';
import 'package:revolvair/domain/failures/repository_failure.dart';
import 'package:revolvair/domain/usecases/get_stations_use_case.dart';
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'package:revolvair/infra/repositories/stations_repository.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../fakers/latestStations_faker.dart';
import '../fakers/stations_faker.dart';

class HttpClientMock extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main() {
  group('GetStationUseCase', () {
    late GetStationsUseCase getStationsUseCase;
    late HttpClientMock mockHttpClient;
    late StationsRepository stationsRepository;
    setUp(() async {
      mockHttpClient = HttpClientMock();
      stationsRepository = StationsRepository(httpClient: mockHttpClient);
      getStationsUseCase = GetStationsUseCase(stationsRepository: stationsRepository);
      registerFallbackValue(FakeUri());
      await dotenv.load(fileName: ".env");
    });

    test(
        'Execute stations returns the expected JSON on a 200 status code',
        () async {
      // Arrange
      Stations expectedStations = StationsFaker().create();
      final httpResponse =
          http.Response(jsonEncode(expectedStations.toJson()), 200);
      String url = stationsUrl;
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => Future.value(httpResponse));
      // Act
      final result =
          await getStationsUseCase.executeStations();
      // Assert
      expect(result, expectedStations);
    });
    
    test(
        'Execute stations throws HttpException on a 404 status code on',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Not Found', 404)));

      // Act & Assert
      expect(
        () async =>
            await getStationsUseCase.executeStations(),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    
    test('Execute stations throws HttpException on a 500 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Server error', 500)));

      // Act & Assert
      expect(
        () async =>
            await getStationsUseCase.executeStations(),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    
    test('Execute stations throws a NetworkFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(NetworkFailure());
      // Assert
      expect(
          () async =>
              await getStationsUseCase.executeStations(),
          throwsA(isA<NetworkFailure>()));
    });
    
    test('Execute stations throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getStationsUseCase.executeStations(),
          throwsA(isA<RepositoryFailure>()));
    });
     test(
        'Execute latestStations returns the expected JSON on a 200 status code',
        () async {
      // Arrange
      LatestStations expectedLatestStations = LateststationsFaker().create();
      final httpResponse =
          http.Response(jsonEncode(expectedLatestStations.toJson()), 200);
      String url = latestStations;
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => Future.value(httpResponse));
      // Act
      final result =
          await getStationsUseCase.executeLatestStations();
      // Assert
      expect(result, expectedLatestStations);
    });
       test(
        'Execute latestStations throws HttpException on a 404 status code on',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Not Found', 404)));

      // Act & Assert
      expect(
        () async =>
            await getStationsUseCase.executeLatestStations(),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    
    test('Execute latestStations throws HttpException on a 500 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Server error', 500)));

      // Act & Assert
      expect(
        () async =>
            await getStationsUseCase.executeLatestStations(),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    
    test('Execute latestStations throws a NetworkFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(NetworkFailure());
      // Assert
      expect(
          () async =>
              await getStationsUseCase.executeLatestStations(),
          throwsA(isA<NetworkFailure>()));
    });
    
    test('Execute latestStations throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getStationsUseCase.executeLatestStations(),
          throwsA(isA<RepositoryFailure>()));
    });


  });
}
