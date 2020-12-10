import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/mapper.dart';
import 'package:sweaterweather/data/storage/detailed_weather_storage.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/detailed_weather.dart';

class DetailedWeatherRepository {
  final WeatherApi _weatherApi;
  final DetailedWeatherStorage _weatherStorage;
  final _mapper = Mapper();

  DetailedWeatherRepository(this._weatherApi, this._weatherStorage);

  Future<List<DetailedWeather>> getAllWeather() async {
    final items = await _weatherStorage.getWeather();
    return items.toList();
  }

  Future<DetailedWeather> getWeatherForCity(City city) async {
    final result = await _weatherApi.getDetailedWeatherByLocation(city.lat, city.lon);
    final weather = await _mapper.mapDetailedWeatherResponse(result, city);
    await _saveWeather(weather);
    return weather;
  }

  Future<void> _saveWeather(DetailedWeather weather) async {
    final List<DetailedWeather> weatherList = await _weatherStorage.getWeather();
    weatherList.removeWhere((element) => element.weather.city.id == weather.weather.city.id);
    weatherList.add(weather);
    await _weatherStorage.saveWeather(weatherList);
  }
}
