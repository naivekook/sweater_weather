import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/detailed_weather_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/data/storage/detailed_weather_storage.dart';
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/utils/day_night_palette.dart';

GetIt getIt = GetIt.instance;

class AppStarter {
  Future init() async {
    await DotEnv().load('.env');
    _initGraph();
  }

  _initGraph() {
    final _weatherApi = WeatherApi(DotEnv().env['WEATHER_API_KEY']);

    getIt.registerSingleton(CityRepository(_weatherApi, CityStorage()));
    getIt.registerSingleton(WeatherRepository(_weatherApi, WeatherStorage()));
    getIt.registerSingleton(DetailedWeatherRepository(_weatherApi, DetailedWeatherStorage()));
    getIt.registerSingleton(DayNightPalette());
  }
}
