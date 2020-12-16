
import 'package:hive/hive.dart';
import 'package:sweaterweather/models/hive/weather.dart';

class WeatherStorage {
  static const _WEATHER_KEY = 'saved_weather';

  Future<List<Weather>> getWeather() async {
    final box = await Hive.openBox(_WEATHER_KEY);
    return box.values.toList().cast<Weather>();
  }

  Future<void> saveWeather(List<Weather> weather) async {
    final box = await Hive.openBox(_WEATHER_KEY);
    weather.forEach((element) {
      box.put(element.city.id, element);
    });
  }
}
