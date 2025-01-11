import 'package:revolvair/infra/repositories/secure_storage_repository.dart';

class LoadSessionUseCase {

  final SecureStorageRepository repository;
  LoadSessionUseCase({required this.repository});

  Future<String?> executeGetToken()async  {
  return await repository.getToken();
  }
  
  Future<void> executeDeleteToken() async {
    repository.deleteToken();
  }
}