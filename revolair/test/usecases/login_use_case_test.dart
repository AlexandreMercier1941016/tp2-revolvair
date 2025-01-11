import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:revolvair/domain/failures/invalid_cred_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/domain/usecases/login_use_case.dart';
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'package:revolvair/infra/repositories/secure_storage_repository.dart';
import 'package:revolvair/infra/token/auth_service.dart';
import 'package:revolvair/infra/token/token_manager.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpClientMock extends Mock implements http.Client {}
class StorageMock extends Mock implements FlutterSecureStorage {}
class FakeUri extends Fake implements Uri {}

void main() {
  group('LoginUseCase', () {
    late LoginUseCase loginUseCase;
    late TokenManager tokenManager;
    late HttpClientMock mockHttpClient;
    late AuthService authService;
    late StorageMock storageMock;
    late SecureStorageRepository secureStorageRepository;
    setUp(() async {
      mockHttpClient = HttpClientMock();
      storageMock = StorageMock();
      secureStorageRepository = SecureStorageRepository(storage: storageMock);
      tokenManager = TokenManager(repository: secureStorageRepository);
      authService = AuthService(tokenManager: tokenManager,httpClient: mockHttpClient);
      loginUseCase = LoginUseCase(authService: authService);
      registerFallbackValue(FakeUri());
      await dotenv.load(fileName: ".env");
    });
    test('Login successful', () async {
        String email = "123@123.123";
        String password = "123123";
        const token = 'valid-token';
        when(() => mockHttpClient.post(
              Uri.parse(loginRoute),
              headers: any(named: 'headers'),
              body: jsonEncode({'email': email, 'password': password}),
            )).thenAnswer(
          (_) async => http.Response(jsonEncode({'token': token}), 200),
        );
        when(() => storageMock.write(key: "token", value: token)).thenAnswer(
          (_) async => Future.value(),
        );

        // Act
        await loginUseCase.execute(email, password);

      verify(() => storageMock.write(key: "token", value: token)).called(1);
      });

      test('Login fails avec des creds invalides lance InvalidCredFailure', () async {
        String email = "invalidemail@gmail.com";
        String password = "admin";
        String expecetedBody = jsonEncode({'email': email, 'password': password});
        // Arrange
        when(() => mockHttpClient.post(
              Uri.parse(loginRoute),
            headers: any(named: 'headers'),
            body: jsonEncode({'email': email, 'password': password}),
          )).thenAnswer(
        (_) async => http.Response(expecetedBody, 401),
      );

      // Act & Assert
      expect(
        () async => await loginUseCase.execute(email, password),
        throwsA(isA<InvalidCredFailure>()),
      );
    });
    
    test('Execute login lance une erreur UseCaseFailure ', () async {
      // Arrange
      String email = "123@123.123";
      String password = "123123";
      when(() => mockHttpClient.post(
            Uri.parse(loginRoute),
            headers: any(named: 'headers'),
            body: jsonEncode({'email': email, 'password': password}),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode({'une erreur est survenue'}), 500),
      );
      when(() => storageMock.write(key: "token", value: any(named: "value")))
      .thenAnswer((_) async {});

      // Act & Assert
      expect(
        () async => await loginUseCase.execute(email, password),
        throwsA(isA<UseCaseFailure>()),
      );
    });

  });
}
