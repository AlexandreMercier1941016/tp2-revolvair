// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i10;

import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality_range.dart'
    as _i9;
import 'package:revolvair/presentation/views/air_quality/air_quality_view.dart'
    as _i3;
import 'package:revolvair/presentation/views/air_quality_detail/air_quality_detail_view.dart'
    as _i4;
import 'package:revolvair/presentation/views/home/home_view.dart' as _i2;
import 'package:revolvair/presentation/views/login/login_view.dart' as _i5;
import 'package:revolvair/presentation/views/register/register_view.dart'
    as _i6;
import 'package:revolvair/presentation/views/stations/station_view.dart' as _i7;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const homeView = '/home-view';

  static const airQualityView = '/air-quality-view';

  static const airQualityDetailView = '/air-quality-detail-view';

  static const loginView = '/login-view';

  static const registerView = '/register-view';

  static const stationView = '/station-view';

  static const all = <String>{
    homeView,
    airQualityView,
    airQualityDetailView,
    loginView,
    registerView,
    stationView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.airQualityView,
      page: _i3.AirQualityView,
    ),
    _i1.RouteDef(
      Routes.airQualityDetailView,
      page: _i4.AirQualityDetailView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i6.RegisterView,
    ),
    _i1.RouteDef(
      Routes.stationView,
      page: _i7.StationView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.AirQualityView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.AirQualityView(),
        settings: data,
      );
    },
    _i4.AirQualityDetailView: (data) {
      final args = data.getArgs<AirQualityDetailViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.AirQualityDetailView(
            key: args.key,
            range: args.range,
            source: args.source,
            url: args.url),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.LoginView(),
        settings: data,
      );
    },
    _i6.RegisterView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.RegisterView(),
        settings: data,
      );
    },
    _i7.StationView: (data) {
      final args = data.getArgs<StationViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.StationView(key: args.key, slug: args.slug, color: args.color),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AirQualityDetailViewArguments {
  const AirQualityDetailViewArguments({
    this.key,
    required this.range,
    required this.source,
    required this.url,
  });

  final _i8.Key? key;

  final _i9.AirQualityRange range;

  final String source;

  final String url;

  @override
  String toString() {
    return '{"key": "$key", "range": "$range", "source": "$source", "url": "$url"}';
  }

  @override
  bool operator ==(covariant AirQualityDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.range == range &&
        other.source == source &&
        other.url == url;
  }

  @override
  int get hashCode {
    return key.hashCode ^ range.hashCode ^ source.hashCode ^ url.hashCode;
  }
}

class StationViewArguments {
  const StationViewArguments({
    this.key,
    required this.slug,
    required this.color,
  });

  final _i8.Key? key;

  final String slug;

  final _i10.Color color;

  @override
  String toString() {
    return '{"key": "$key", "slug": "$slug", "color": "$color"}';
  }

  @override
  bool operator ==(covariant StationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.slug == slug && other.color == color;
  }

  @override
  int get hashCode {
    return key.hashCode ^ slug.hashCode ^ color.hashCode;
  }
}

extension NavigatorStateExtension on _i11.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAirQualityView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.airQualityView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAirQualityDetailView({
    _i8.Key? key,
    required _i9.AirQualityRange range,
    required String source,
    required String url,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.airQualityDetailView,
        arguments: AirQualityDetailViewArguments(
            key: key, range: range, source: source, url: url),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStationView({
    _i8.Key? key,
    required String slug,
    required _i10.Color color,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.stationView,
        arguments: StationViewArguments(key: key, slug: slug, color: color),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAirQualityView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.airQualityView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAirQualityDetailView({
    _i8.Key? key,
    required _i9.AirQualityRange range,
    required String source,
    required String url,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.airQualityDetailView,
        arguments: AirQualityDetailViewArguments(
            key: key, range: range, source: source, url: url),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStationView({
    _i8.Key? key,
    required String slug,
    required _i10.Color color,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.stationView,
        arguments: StationViewArguments(key: key, slug: slug, color: color),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
