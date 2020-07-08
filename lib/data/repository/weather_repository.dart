import 'package:sweaterweather/data/services/weather_service.dart';
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/weather.dart';
import 'package:sweaterweather/models/weather_extended.dart';

class WeatherRepository {
  final WeatherService _weatherService;
  final WeatherStorage _weatherStorage;

  WeatherRepository(this._weatherService, this._weatherStorage);

  Future<List<Weather>> getAllWeather() async {
    final items = await _weatherStorage.getWeather();
    return items.map((e) => e.weather).toList();
  }

  Future<Weather> getWeatherForCity(City city) async {
    final result = await _weatherService.getWeatherByCityId(city.id);
    if (result.isSuccess()) {
      await _saveWeather(result.successValue);
      return result.successValue;
    } else {
      print(result.errorValue);
      return null;
    }
  }

  Future<Weather> getWeatherForCityByName(String query) async {
    final result = await _weatherService.getWeatherByCityId(city.id);
    if (result.isSuccess()) {
      await _saveWeather(result.successValue);
      return result.successValue;
    } else {
      print(result.errorValue);
      return null;
    }
  }

  Future<void> _saveWeather(Weather weather) async {
    final List<WeatherExtended> weatherList =
        await _weatherStorage.getWeather();
    weatherList.removeWhere((element) => element.location == weather.location);
    weatherList
        .add(WeatherExtended(location: weather.location, weather: weather));
    await _weatherStorage.saveWeather(weatherList);
  }
}
