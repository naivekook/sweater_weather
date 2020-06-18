import 'package:sweaterweather/data/services/weather_service.dart';
import 'package:sweaterweather/data/storage/detailed_weather_storage.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/models/detailed_weather_extended.dart';

class DetailedWeatherRepository {
  final WeatherService _weatherService;
  final DetailedWeatherStorage _weatherStorage;

  DetailedWeatherRepository(this._weatherService, this._weatherStorage);

  Future<void> saveDetailedWeather(DetailedWeather weather) async {
    final List<DetailedWeatherExtended> weatherList = await _weatherStorage.getDetailedWeather();
    weatherList.removeWhere((element) => element.location == weather.location);
    weatherList.add(DetailedWeatherExtended(location: weather.location, weather: weather));
    await _weatherStorage.saveDetailedWeather(weatherList);
  }

  Future<List<DetailedWeather>> getDetailedWeather() async {
    final items = await _weatherStorage.getDetailedWeather();
    return items.map((e) => e.weather);
  }
}
