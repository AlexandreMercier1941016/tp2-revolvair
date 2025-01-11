import 'package:flutter_dotenv/flutter_dotenv.dart';

var baseUrl = dotenv.get('API_REVOLVAIR_URL');
var revolvairUrl = "$baseUrl/revolvair/aqi/revolvair";
var canadaUrl = "$baseUrl/revolvair/aqi/aqhi";
var iqaEpaUs = "$baseUrl/revolvair/aqi/usepa";
var stationsUrl = "$baseUrl/revolvair/stations";
var latestStations = "$baseUrl/revolvair/stations/measures/pm25/last";
var register = "$baseUrl/register";
var stationInfos = "infos";
var stationMeasures = "measures/pm25/last";
var stationMeasure24h = "measures/pm25_raw/average/24h";
var loginRoute = "$baseUrl/login";