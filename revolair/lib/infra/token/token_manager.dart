import 'package:revolvair/infra/repositories/secure_storage_repository.dart';
class TokenManager {
  
  final SecureStorageRepository repository;
  TokenManager({required this.repository});

  setToken(String token) async {
    repository.setToken(token);
  }
  getToken() async {
    return repository.getToken();
  }
  deleteToken() async {
    repository.deleteToken();
  }
}