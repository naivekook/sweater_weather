import 'package:hive/hive.dart';
import 'package:sweaterweather/models/hive/weather_details.dart';

class DetailedWeatherStorage {
  static const _DETAILED_WEATHER_KEY = 'saved_detailed_weather';

  Future<List<WeatherDetails>> getWeather() async {
    final box = await Hive.openBox(_DETAILED_WEATHER_KEY);
    return box.values.toList().cast<WeatherDetails>();
  }

  Future<void> saveWeather(List<WeatherDetails> weather) async {
    final box = await Hive.openBox(_DETAILED_WEATHER_KEY);
    weather.forEach((element) {
      box.put(element.city.id, element);
    });
  }
}
