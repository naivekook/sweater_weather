import 'package:hive/hive.dart';
import 'package:sweaterweather/models/hive/weather.dart';

class WeatherStorage {
  static const _WEATHER_KEY = 'saved_weather';

  Future<List<Weather>> getAllWeather() async {
    Box box = await Hive.openBox(_WEATHER_KEY);
    return box.values.toList().cast<Weather>();
  }

  Future saveWeather(Weather weather) async {
    Box box = await Hive.openBox(_WEATHER_KEY);
    box.put(weather.city.id, weather);
  }

  Future saveAllWeather(List<Weather> weather) async {
    Box box = await Hive.openBox(_WEATHER_KEY);
    weather.forEach((element) {
      box.put(element.city.id, element);
    });
  }

  Future<Weather> findWeatherByCityId(int cityId) async {
    Box box = await Hive.openBox(_WEATHER_KEY);
    return box.get(cityId);
  }

  Future<Weather> findWeatherByLocation(double lat, double lon) async {
    Box box = await Hive.openBox(_WEATHER_KEY);
    return box.values.cast<Weather>().firstWhere(
          (element) => element.city.lat == lat && element.city.lon == lon,
          orElse: () => null,
        );
  }
}
