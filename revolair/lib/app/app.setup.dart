import "package:get_it/get_it.dart";
import "package:revolvair/domain/usecases/get_air_quality_use_case.dart";
import "package:revolvair/domain/usecases/get_stations_measures_use_case.dart";
import "package:revolvair/domain/usecases/get_stations_use_case.dart";
import "package:revolvair/domain/usecases/load_session_use_case.dart";
import "package:revolvair/infra/repositories/air_quality_repository.dart";
import "package:revolvair/infra/repositories/stations_measures_repository.dart";
import "package:revolvair/infra/repositories/secure_storage_repository.dart";
import "package:revolvair/infra/repositories/stations_repository.dart";
import "package:revolvair/domain/usecases/get_user_use_case.dart";
import "package:revolvair/infra/repositories/user_repository.dart";
import "package:revolvair/infra/token/auth_service.dart";
import "package:revolvair/infra/token/token_manager.dart";
import "package:stacked_services/stacked_services.dart";
import 'package:revolvair/domain/usecases/login_use_case.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

GetIt locator = GetIt.instance;

class AppSetup {
  static Future<void> setupLocator() async {
    _registerServices();
    _registerUseCases();
  }

  static void _registerServices() {
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
    locator.registerLazySingleton(() => http.Client());
    locator.registerLazySingleton(() => const FlutterSecureStorage());
    locator.registerLazySingleton(() => SecureStorageRepository(storage: locator<FlutterSecureStorage>()));
    locator.registerLazySingleton<AirQualityRepository>(
        () => AirQualityRepository(httpClient: locator<http.Client>()));
    locator.registerLazySingleton<StationsRepository>(
        () => StationsRepository(httpClient: locator<http.Client>()));
    locator.registerLazySingleton<UserRepository>(
        () => UserRepository(httpClient: locator<http.Client>()));
    locator.registerLazySingleton<StationsMeasuresRepository>(() => StationsMeasuresRepository(httpClient: locator<http.Client>()));
    locator.registerLazySingleton(() => TokenManager(repository:  locator<SecureStorageRepository>()));
    locator.registerLazySingleton(() => AuthService(tokenManager: locator<TokenManager>(), httpClient: locator<http.Client>()));
  }

  static void _registerUseCases() {
    locator.registerLazySingleton<GetAirQualityUseCase>(
        () => GetAirQualityUseCase(repo: locator<AirQualityRepository>()));
    locator.registerLazySingleton<GetStationsUseCase>(
        () => GetStationsUseCase(stationsRepository: locator<StationsRepository>()));
    locator.registerLazySingleton<GetUserUseCase>(
        ()=> GetUserUseCase(repo: locator<UserRepository>()));
    locator.registerLazySingleton<GetStationsMeasuresUseCase>(
        ()=> GetStationsMeasuresUseCase(stationsMeasuresRepository: locator<StationsMeasuresRepository>()));
    locator.registerLazySingleton<LoadSessionUseCase>(
        ()=> LoadSessionUseCase(repository: locator<SecureStorageRepository>()));
    locator.registerLazySingleton<LoginUseCase>(
        ()=> LoginUseCase(authService: locator<AuthService>()));
  }
}
