import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/mapper.dart';
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/hive/weather.dart';

class WeatherRepository {
  final WeatherApi _weatherApi;
  final WeatherStorage _weatherStorage;
  final _mapper = Mapper();

  WeatherRepository(this._weatherApi, this._weatherStorage);

  Future<List<Weather>> getAllWeather() async {
    final items = await _weatherStorage.getWeather();
    return items.toList();
  }

  Future<Weather> getWeatherForCity(City city) async {
    final result = await _weatherApi.getWeatherByCityId(city.id);
    final weather = await _mapper.mapWeatherResponse(result);
    await _saveWeather(weather);
    return weather;
  }

  Future<Weather> getWeatherForLocation(double lat, double lon) async {
    final result = await _weatherApi.getWeatherByLocation(lat, lon);
    final weather = await _mapper.mapWeatherResponse(result);
    await _saveWeather(weather);
    return weather;
  }

  Future<void> _saveWeather(Weather weather) async {
    final List<Weather> weatherList = await _weatherStorage.getWeather();
    weatherList.removeWhere((element) => element.city.id == weather.city.id);
    weatherList.add(weather);
    await _weatherStorage.saveWeather(weatherList);
  }
}
