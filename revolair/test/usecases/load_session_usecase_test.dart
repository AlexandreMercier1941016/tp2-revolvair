import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:revolvair/domain/usecases/load_session_use_case.dart';
import 'package:revolvair/infra/repositories/secure_storage_repository.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StorageMock extends Mock implements FlutterSecureStorage {}

void main() {
  group('LoadSessionUseCase', () {
    late LoadSessionUseCase loadSessionUseCase;
    late StorageMock storageMock;
    late SecureStorageRepository secureStorageRepository;
    setUp(() async {
      storageMock = StorageMock();
      secureStorageRepository= SecureStorageRepository(storage: storageMock);
      loadSessionUseCase = LoadSessionUseCase(repository: secureStorageRepository);
      await dotenv.load(fileName: ".env");
    });

    test(
        'ExecuteGetToken retourne un token',
        () async {
          
      String expectedToken = "token";
      when(() => storageMock.read(key: expectedToken)).thenAnswer((_) async => expectedToken);

      final result = await loadSessionUseCase.executeGetToken();
      expect(result,expectedToken);
    });
       test(
        'ExecuteGetToken retourne null lorsque pas de token',
        () async {
      when(() => storageMock.read(key: "token")).thenAnswer((_) async => null);

      final result = await loadSessionUseCase.executeGetToken();
      expect(result,null);
    });
      test(
        'ExecuteDeleteToken retire le token',
        () async {
      when(() => storageMock.delete(key: "token")).thenAnswer((_) async {});

      await loadSessionUseCase.executeDeleteToken();
     
      verify(() => storageMock.delete(key: "token")).called(1); 
    });

  });
  
}
