import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/detailed_weather_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/data/storage/detailed_weather_storage.dart';
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/hive/weather.dart';
import 'package:sweaterweather/models/hive/weather_by_day.dart';
import 'package:sweaterweather/models/hive/weather_by_hour.dart';
import 'package:sweaterweather/models/hive/weather_details.dart';
import 'package:sweaterweather/services/current_location_service.dart';
import 'package:sweaterweather/services/weather_expiration_service.dart';
import 'package:sweaterweather/services/weather_updater_service.dart';
import 'package:sweaterweather/utils/day_night_palette.dart';

GetIt getIt = GetIt.instance;

class AppStarter {
  Future init() async {
    await DotEnv().load('.env');
    await _initHive();
    _initGraph();
    await _migrateToHive();
  }

  _initGraph() {
    getIt.registerSingleton(WeatherApi(DotEnv().env['WEATHER_API_KEY']));
    getIt.registerSingleton(WeatherExpirationService());
    getIt.registerSingleton(DayNightPalette());
    getIt.registerSingleton(CurrentLocationService());

    getIt.registerSingleton(CityStorage());
    getIt.registerSingleton(WeatherStorage());
    getIt.registerSingleton(DetailedWeatherStorage());

    getIt.registerSingleton(CityRepository(getIt.get(), getIt.get()));
    getIt.registerSingleton(WeatherRepository(getIt.get(), getIt.get(), getIt.get()));
    getIt.registerSingleton(DetailedWeatherRepository(getIt.get(), getIt.get()));

    getIt.registerSingleton(WeatherUpdaterService(getIt.get(), getIt.get()));
  }

  Future _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CityAdapter());
    Hive.registerAdapter(WeatherAdapter());
    Hive.registerAdapter(WeatherByHourAdapter());
    Hive.registerAdapter(WeatherByDayAdapter());
    Hive.registerAdapter(WeatherDetailsAdapter());
  }

  Future _migrateToHive() async {
    final prefs = await SharedPreferences.getInstance();

    String json = prefs.getString('saved_cities');
    if (json != null) {
      List<dynamic> citiesDecoded = jsonDecode(json);
      List<City> cities = citiesDecoded
          .map((e) => City(
                e['id'],
                e['name'],
                e['country_name'],
                e['country_code'],
                e['lat'] as double,
                e['lon'] as double,
              ))
          .toList();
      await getIt.get<CityStorage>().save(cities);
    }

    prefs.remove('saved_cities');
    prefs.remove('saved_weather');
    prefs.remove('saved_detailed_weather');
  }
}
