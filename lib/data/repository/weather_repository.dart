
import 'package:sweaterweather/data/api/dto/weather_dto.dart';
import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/mapper.dart';
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/hive/weather.dart';
import 'package:sweaterweather/services/weather_expiration_service.dart';

class WeatherRepository {
  final WeatherApi _weatherApi;
  final WeatherStorage _weatherStorage;
  final WeatherExpirationService _weatherExpirationService;
  final _mapper = Mapper();

  WeatherRepository(this._weatherApi, this._weatherStorage, this._weatherExpirationService);

  Future<List<Weather>> getAllWeather() => _weatherStorage.getAllWeather();

  Future<Weather> getWeatherForCity(City city) async {
    Weather savedWeather = await _weatherStorage.findWeatherByCityId(city.id);
    if (savedWeather != null && !_weatherExpirationService.isWeatherExpired(savedWeather)) {
      return savedWeather;
    } else {
      WeatherDto result = await _weatherApi.getWeatherByCityId(city.id);
      Weather fetchedWeather = await _mapper.mapWeatherResponse(result);
      await _save(fetchedWeather);
      return fetchedWeather;
    }
  }

  Future<Weather> getWeatherForLocation(double lat, double lon) async {
    Weather savedWeather = await _weatherStorage.findWeatherByLocation(lat, lon);
    if (savedWeather != null && !_weatherExpirationService.isWeatherExpired(savedWeather)) {
      return savedWeather;
    } else {
      WeatherDto result = await _weatherApi.getWeatherByLocation(lat, lon);
      Weather fetchedWeather = await _mapper.mapWeatherResponse(result);
      await _save(fetchedWeather);
      return fetchedWeather;
    }
  }

  Future<void> _save(Weather weather) => _weatherStorage.saveWeather(weather);
}
