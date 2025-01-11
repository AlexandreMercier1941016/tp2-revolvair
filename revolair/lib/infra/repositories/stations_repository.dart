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

class StationsRepository {
  final http.Client httpClient;

  StationsRepository({required this.httpClient});

  Future<Map<String, dynamic>> getStationsFromRevolvair() async {
    try {
      var response = await httpClient.get(Uri.parse(stationsUrl));
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body);
        default:
          throw HttpResponseFailure(
              message: LocaleKeys.errors_httpErrorsTitle.tr(),
              context: getExecutionContext());
      }
    } on HttpResponseFailure {
      rethrow;
    } on SocketException catch (e) {
      throw NetworkFailure(
          message: LocaleKeys.errors_networkErrorTitle.tr(),
          context: e.toString() + getExecutionContext());
    } catch (e) {
      throw RepositoryFailure(
          message: LocaleKeys.errors_repositoryErrorTitle.tr(),
          context: e.toString() + getExecutionContext());
    }
  
  }
    Future<Map<String, dynamic>> getLatestStationsFromRevolvair() async {
    try {
      var response = await httpClient.get(Uri.parse(latestStations));
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body);
        default:
          throw HttpResponseFailure(
              message: LocaleKeys.errors_httpErrorsTitle.tr(),
              context: getExecutionContext());
      }
    } on HttpResponseFailure {
      rethrow;
    } on SocketException catch (e) {
      throw NetworkFailure(
          message: LocaleKeys.errors_networkErrorTitle.tr(),
          context: e.toString() + getExecutionContext());
    } catch (e) {
      throw RepositoryFailure(
          message: LocaleKeys.errors_repositoryErrorTitle.tr(),
          context: e.toString() + getExecutionContext());
    }
  
  }
}