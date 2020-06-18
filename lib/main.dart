import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/detailed_weather_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/data/services/weather_service.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/data/storage/detailed_weather_storage.dart';
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/router.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  await DotEnv().load('.env');
  final _weatherService = WeatherService(DotEnv().env['WEATHER_API_KEY']);

  getIt.registerSingleton(CityRepository(_weatherService, CityStorage()));
  getIt.registerSingleton(WeatherRepository(_weatherService, WeatherStorage()));
  getIt.registerSingleton(DetailedWeatherRepository(_weatherService, DetailedWeatherStorage()));

  return runApp(MyApp());
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
