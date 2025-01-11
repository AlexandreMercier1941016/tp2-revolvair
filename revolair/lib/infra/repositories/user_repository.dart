import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:revolvair/domain/failures/http_response_failure.dart';
import 'package:revolvair/domain/failures/network_failure.dart';
import 'package:revolvair/domain/failures/repository_failure.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';

class UserRepository {
  final http.Client httpClient;
  UserRepository({required this.httpClient});

  Future<Map<String,dynamic>> createUser(Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse(register);
      final response = await httpClient.post(
        uri,
        headers:{
          'Content-Type':'application/json',
          'Accept':'application/json',  
        },
        body: jsonEncode(data),
        );
    
    switch(response.statusCode){
      case 201:
        return jsonDecode(response.body) as Map<String, dynamic>;
    default:
       throw HttpResponseFailure(
         message: LocaleKeys.errors_httpErrorsTitle.tr(),
          context: getExecutionContext());
    }
    } on HttpResponseFailure {
      rethrow;
    }
    on SocketException catch (e) {
      throw NetworkFailure(
          message: LocaleKeys.errors_networkErrorTitle.tr(),
          context: e.toString() + getExecutionContext());
    }
    
    catch (e) {
      throw RepositoryFailure(
          message: LocaleKeys.errors_repositoryErrorTitle.tr(),
          context: e.toString() + getExecutionContext());

    }
  }
}