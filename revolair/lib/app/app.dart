import 'package:revolvair/presentation/views/air_quality_detail/air_quality_detail_view.dart';
import 'package:revolvair/presentation/views/home/home_view.dart';
import 'package:revolvair/presentation/views/air_quality/air_quality_view.dart';
import 'package:revolvair/presentation/views/login/login_view.dart';
import 'package:revolvair/presentation/views/register/register_view.dart';
import 'package:revolvair/presentation/views/stations/station_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeView),
  MaterialRoute(page: AirQualityView),
  MaterialRoute(page: AirQualityDetailView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: RegisterView),
  MaterialRoute(page: StationView)
])
class App {}
