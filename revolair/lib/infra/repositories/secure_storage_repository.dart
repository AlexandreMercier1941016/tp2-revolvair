import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
   final FlutterSecureStorage storage;
  SecureStorageRepository({required this.storage});

  setToken(String token) async {
    await storage.write(key: 'token', value: token);
  }
  Future<String?> getToken() async {
   return await storage.read(key: 'token');
  }
  deleteToken() async {
  await storage.delete(key: 'token');  
  }
}