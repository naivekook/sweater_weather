import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/mapper.dart';
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/weather.dart';

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
    if (result.isSuccess()) {
      final weather = _mapper.mapWeatherResponse(result.successValue);
      await _saveWeather(weather);
      return weather;
    } else {
      print(result.errorValue);
      return null;
    }
  }

  Future<Weather> getWeatherForLocation(double lat, double lon) async {
    final result = await _weatherApi.getWeatherByLocation(lat, lon);
    if (result.isSuccess()) {
      final weather = _mapper.mapWeatherResponse(result.successValue);
      await _saveWeather(weather);
      return weather;
    } else {
      print(result.errorValue);
      return null;
    }
  }

  Future<void> _saveWeather(Weather weather) async {
    final List<Weather> weatherList = await _weatherStorage.getWeather();
    weatherList.removeWhere((element) => element.cityId == weather.cityId);
    weatherList.add(weather);
    await _weatherStorage.saveWeather(weatherList);
  }
}
