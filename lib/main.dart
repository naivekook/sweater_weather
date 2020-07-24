import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/router.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  Crashlytics.instance.enableInDevMode = !kReleaseMode;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await DotEnv().load('.env');
  final _weatherApi = WeatherApi(DotEnv().env['WEATHER_API_KEY']);

  getIt.registerSingleton(CityRepository(_weatherApi, CityStorage()));
  getIt.registerSingleton(WeatherRepository(_weatherApi, WeatherStorage()));

  runZoned(() {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      onGenerateRoute: Router.generateRoute,
      initialRoute: Router.HOME,
    );
  }
}
