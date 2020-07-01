import 'package:sweaterweather/data/services/weather_service.dart';
import 'package:sweaterweather/data/storage/detailed_weather_storage.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/models/detailed_weather_extended.dart';
import 'package:sweaterweather/models/location.dart';

class DetailedWeatherRepository {
  final WeatherService _weatherService;
  final DetailedWeatherStorage _weatherStorage;

  DetailedWeatherRepository(this._weatherService, this._weatherStorage);

  Future<List<DetailedWeather>> getAllWeather() async {
    final items = await _weatherStorage.getDetailedWeather();
    return items.map((e) => e.weather);
  }

  Future<DetailedWeather> getWeatherForLocation(Location location) async {
    final result = await _weatherService.getWeatherOneCall(location);
    if (result.isSuccess()) {
      await _saveWeather(result.successValue);
      return result.successValue;
    } else {
      print(result.errorValue);
      return null;
    }
  }

  Future<void> _saveWeather(DetailedWeather weather) async {
    final List<DetailedWeatherExtended> weatherList =
        await _weatherStorage.getDetailedWeather();
    weatherList.removeWhere((element) => element.location == weather.location);
    weatherList.add(
        DetailedWeatherExtended(location: weather.location, weather: weather));
    await _weatherStorage.saveDetailedWeather(weatherList);
  }
}
