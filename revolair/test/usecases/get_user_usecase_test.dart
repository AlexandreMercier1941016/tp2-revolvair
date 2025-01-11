import 'dart:convert';
import 'package:revolvair/domain/failures/http_response_failure.dart';
import 'package:revolvair/domain/failures/repository_failure.dart';
import 'package:revolvair/domain/usecases/get_user_use_case.dart';
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'package:revolvair/infra/repositories/user_repository.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:revolvair/domain/entities/user.dart';
import '../fakers/user_faker.dart';

class HttpClientMock extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('GetUserUseCase', () {
    late GetUserUseCase getUserUseCase;
    late HttpClientMock mockHttpClient;
    late UserRepository userRepository;
    setUp(() async {
      mockHttpClient = HttpClientMock();
      userRepository = UserRepository(httpClient: mockHttpClient);
      getUserUseCase = GetUserUseCase(repo: userRepository);
      registerFallbackValue(FakeUri());
      await dotenv.load(fileName: ".env");
    });

    test(
        'Execute with valid user data returns the expected user on a 201 status code',
        () async {
      User expectedUser = UserFaker().create();
      final httpResponse =
          http.Response(jsonEncode(expectedUser.toJson()), 201);

      String url = register;
      when(() => mockHttpClient.post(
            Uri.parse(url),
            headers: any(named: 'headers'),
            body: jsonEncode(expectedUser.toJson()),
          )).thenAnswer((_) async => httpResponse);

      final result =
          await getUserUseCase.executeCreateUser(expectedUser.toJson());
      expect(result, expectedUser.toJson());
    });
    test(
        'Execute with valid user data throws HttpException on a 404 status code on',
        () async {
      User expectedUser = UserFaker().create();
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () async =>
            await getUserUseCase.executeCreateUser(expectedUser.toJson()),
        throwsA(isA<HttpResponseFailure>()),
      );
    });
    test('Execute with valid user data throws HttpException on a 500 status code on',
        ()async {
      User expectedUser = UserFaker().create();
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Server error', 500));

      expect(
        () async =>
            await getUserUseCase.executeCreateUser(expectedUser.toJson()),
        throwsA(isA<HttpResponseFailure>()),
      );
    });

     test('Execute with IQA EPA US throws a RepositoryFailure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenThrow(RepositoryFailure());
      // Assert
      expect(
          () async =>
              await getUserUseCase.executeCreateUser(UserFaker().create().toJson()),
          throwsA(isA<RepositoryFailure>()));
    });
  });
}
