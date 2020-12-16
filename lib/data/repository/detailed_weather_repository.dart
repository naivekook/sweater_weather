import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/mapper.dart';
import 'package:sweaterweather/data/storage/detailed_weather_storage.dart';
import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/hive/weather_details.dart';

class DetailedWeatherRepository {
  final WeatherApi _weatherApi;
  final DetailedWeatherStorage _weatherStorage;
  final _mapper = Mapper();

  DetailedWeatherRepository(this._weatherApi, this._weatherStorage);

  Future<List<WeatherDetails>> getAllWeather() async {
    final items = await _weatherStorage.getWeather();
    return items.toList();
  }

  Future<WeatherDetails> getWeatherForCity(City city) async {
    final result = await _weatherApi.getDetailedWeatherByLocation(city.lat, city.lon);
    final weather = await _mapper.mapDetailedWeatherResponse(result, city);
    await _saveWeather(weather);
    return weather;
  }

  Future<void> _saveWeather(WeatherDetails weather) async {
    final List<WeatherDetails> weatherList = await _weatherStorage.getWeather();
    weatherList.removeWhere((element) => element.city.id == weather.city.id);
    weatherList.add(weather);
    await _weatherStorage.saveWeather(weatherList);
  }
}
