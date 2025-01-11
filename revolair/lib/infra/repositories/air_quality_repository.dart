import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:revolvair/domain/failures/http_response_failure.dart';
import 'package:revolvair/domain/failures/network_failure.dart';
import 'package:revolvair/domain/failures/repository_failure.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/air_quality_index.dart';
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'dart:convert';
import 'dart:io';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';

class AirQualityRepository {
  final http.Client httpClient;
  AirQualityRepository({required this.httpClient});

  Future<Map<String, dynamic>> getRevolairAirQuality(
      AirQualityIndex apiRoute) async {
    try {
      var apiUrl = '';
      switch (apiRoute) {
        case AirQualityIndex.revolvair:
          apiUrl = revolvairUrl;   
          break;
        case AirQualityIndex.canada:
          apiUrl = canadaUrl;
          break;
        case AirQualityIndex.epaUs:
          apiUrl = iqaEpaUs;
      }
      var response = await httpClient.get(Uri.parse(apiUrl));
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
