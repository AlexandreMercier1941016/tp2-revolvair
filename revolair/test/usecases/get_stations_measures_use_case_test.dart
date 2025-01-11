import 'dart:convert';
import 'package:revolvair/domain/entities/measures_station/latest_measures_stations.dart';
import 'package:revolvair/domain/entities/measures_station/lives_measures_station.dart';
import 'package:revolvair/domain/entities/measures_station/station_infos.dart';
import 'package:revolvair/domain/failures/http_response_failure.dart';
import 'package:revolvair/domain/failures/network_failure.dart';
import 'package:revolvair/domain/failures/repository_failure.dart';
import 'package:revolvair/domain/usecases/get_stations_measures_use_case.dart';
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'package:revolvair/infra/repositories/stations_measures_repository.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../fakers/latest_measures_stats_faker.dart';
import '../fakers/lives_measures_stats_faker.dart';
import '../fakers/station_infos_faker.dart';

class HttpClientMock extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('GetStationsMeasuresUseCase', () {
    late GetStationsMeasuresUseCase getStationsMeasuresUseCase;
    late HttpClientMock mockHttpClient;
    late StationsMeasuresRepository stationsMeasuresRepository;
    setUp(() async {
      mockHttpClient = HttpClientMock();
      stationsMeasuresRepository = StationsMeasuresRepository(httpClient: mockHttpClient);
      getStationsMeasuresUseCase = GetStationsMeasuresUseCase(stationsMeasuresRepository: stationsMeasuresRepository);
      registerFallbackValue(FakeUri());
      await dotenv.load(fileName: ".env");
    });

    test(
        'Execute lives measures returns the expected JSON on a 200 status code',
        () async {
      // Arrange
      LivesMeasuresStation expectedLiveMeasures = LivesMeasuresStatsFaker().create();
      final httpResponse =
          http.Response(jsonEncode(expectedLiveMeasures.toJson()), 200);
      String url = "$stationsUrl/peace-valley-attachie-flat-upper-terrace-frm/$stationMeasures";
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => Future.value(httpResponse));
      // Act
      final result =
          await getStationsMeasuresUseCase.executeStationsLiveMeasures("peace-valley-attachie-flat-upper-terrace-frm");
      // Assert
      expect(result, expectedLiveMeasures);
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
            await getStationsMeasuresUseCase.executeStationsLiveMeasures("peace-valley-attachie-flat-upper-terrace-frm"),
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
            await getStationsMeasuresUseCase.executeStationsLiveMeasures("peace-valley-attachie-flat-upper-terrace-frm"),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute with Revolvair.org throws a NetworkFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(NetworkFailure());
      // Assert
      expect(
          () async =>
              await getStationsMeasuresUseCase.executeStationsLiveMeasures("peace-valley-attachie-flat-upper-terrace-frm"),
          throwsA(isA<NetworkFailure>()));
    });
    test('Execute with Revolvair.org throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getStationsMeasuresUseCase.executeStationsLiveMeasures("peace-valley-attachie-flat-upper-terrace-frm"),
          throwsA(isA<RepositoryFailure>()));
    });


test(
        'Execute latest measures returns the expected JSON on a 200 status code',
        () async {
      // ArrangeS
      LatestMeasuresStations latestMeasuresStations = LatestMeasuresStationsFaker().create();
      final httpResponse =
          http.Response(jsonEncode(latestMeasuresStations.toJson()), 200);
      String url = "$stationsUrl/peace-valley-attachie-flat-upper-terrace-frm/$stationMeasure24h";
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => Future.value(httpResponse));
      // Act
      final result =
          await getStationsMeasuresUseCase.executeStationsLiveMeasures24h("peace-valley-attachie-flat-upper-terrace-frm");
      // Assert
      expect(result, latestMeasuresStations);
    });
    test(
        'Execute latest stations throws HttpException on a 404 status code on',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Not Found', 404)));

      // Act & Assert
      expect(
        () async =>
            await getStationsMeasuresUseCase.executeStationsLiveMeasures24h("peace-valley-attachie-flat-upper-terrace-frm"),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute latest stations throws HttpException on a 500 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Server error', 500)));

      // Act & Assert
      expect(
        () async =>
            await getStationsMeasuresUseCase.executeStationsLiveMeasures24h("peace-valley-attachie-flat-upper-terrace-frm"),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute latest stations throws a NetworkFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(NetworkFailure());
      // Assert
      expect(
          () async =>
              await getStationsMeasuresUseCase.executeStationsLiveMeasures24h("peace-valley-attachie-flat-upper-terrace-frm"),
          throwsA(isA<NetworkFailure>()));
    });
    test('Execute latest stat throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getStationsMeasuresUseCase.executeStationsLiveMeasures24h("peace-valley-attachie-flat-upper-terrace-frm"),
          throwsA(isA<RepositoryFailure>()));
    });

    test(
        'Execute station infos returns the expected JSON on a 200 status code',
        () async {
      // Arrange
      StationInfos stationsInfos = StationInfosFaker().create();
      final httpResponse =
          http.Response(jsonEncode(stationsInfos.toJson()), 200);
          //print(stationsInfos.toJson());
      String url = "$stationsUrl/peace-valley-attachie-flat-upper-terrace-frm/$stationInfos";
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => Future.value(httpResponse));
      // Act
      final result =
          await getStationsMeasuresUseCase.executeStationsInfos("peace-valley-attachie-flat-upper-terrace-frm");
      // Assert
      expect(result, stationsInfos);
    });
    test(
        'Execute station infos throws HttpException on a 404 status code on',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Not Found', 404)));

      // Act & Assert
      expect(
        () async =>
            await getStationsMeasuresUseCase.executeStationsInfos("peace-valley-attachie-flat-upper-terrace-frm"),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute station infos throws HttpException on a 500 status code',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => Future.value(http.Response('Server error', 500)));

      // Act & Assert
      expect(
        () async =>
            await getStationsMeasuresUseCase.executeStationsInfos("peace-valley-attachie-flat-upper-terrace-frm"),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute station infos throws a NetworkFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(NetworkFailure());
      // Assert
      expect(
          () async =>
              await getStationsMeasuresUseCase.executeStationsInfos("peace-valley-attachie-flat-upper-terrace-frm"),
          throwsA(isA<NetworkFailure>()));
    });
    test('Execute station infos throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getStationsMeasuresUseCase.executeStationsInfos("peace-valley-attachie-flat-upper-terrace-frm"),
          throwsA(isA<RepositoryFailure>()));
    });
  });
}



