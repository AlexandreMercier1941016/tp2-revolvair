import 'dart:convert';
import 'dart:io';
import 'package:revolvair/domain/failures/http_response_failure.dart';
import 'package:revolvair/domain/failures/network_failure.dart';
import 'package:revolvair/domain/failures/repository_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/api_routes.dart';
import 'package:revolvair/infra/helpers/getExecutionContext.dart';

class StationsMeasuresRepository {
  final http.Client httpClient;
  StationsMeasuresRepository({required this.httpClient});
Future<Map<String, dynamic>> getStationsLiveMeasures(String slug) async{
  try{
  var url = "$stationsUrl/$slug/$stationMeasures";
   var response = await httpClient.get(Uri.parse(url));
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
Future<Map<String, dynamic>> getStationsLiveMeasures24h(String slug) async{
  try{
  var url = "$stationsUrl/$slug/$stationMeasure24h";
   var response = await httpClient.get(Uri.parse(url));
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

Future<Map<String, dynamic>> getStationsInfos(String slug) async{
  try{
  var url = "$stationsUrl/$slug/$stationInfos";
    var response = await httpClient.get(Uri.parse(url));
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