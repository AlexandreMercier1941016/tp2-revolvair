import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'package:revolvair/infra/token/token_manager.dart';
import 'package:revolvair/domain/failures/invalid_cred_failure.dart';
import 'package:revolvair/domain/failures/usecase_failure.dart';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';

class AuthService {
  final TokenManager tokenManager;
  final http.Client httpClient;

  AuthService({required this.tokenManager,required this.httpClient});

  Future<void> login(String email, String password) async {
    try {
      final response = await httpClient.post(
        Uri.parse(loginRoute),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        tokenManager.setToken(responseBody['token']);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw InvalidCredFailure(
          message: 'Les identifiants sont invalides.',
          context: getExecutionContext(),
        );
      } else {
        final responseBody = jsonDecode(response.body);
        throw UseCaseFailure(
          message: responseBody['message'] ?? 'Erreur de connexion',
          context: getExecutionContext(),
        );
      }
    } 
    on InvalidCredFailure{
      rethrow;
    }
    catch (e) {
      throw UseCaseFailure(
        message: 'Impossible de se connecter.',
        context: getExecutionContext(),
      );
    }
  }

  void setToken(String token) {
    tokenManager.setToken(token);
  }
}
