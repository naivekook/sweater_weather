import 'package:geolocator/geolocator.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/models/hive/weather.dart';
import 'package:sweaterweather/services/current_location_service.dart';

class WeatherUpdaterService {
  final WeatherRepository _weatherRepository;
  final CurrentLocationService _currentLocationService;

  WeatherUpdaterService(this._weatherRepository, this._currentLocationService);

  Future updateAllWeather() async {
    Position position = await _currentLocationService.getCurrentLocation();
    if (position != null) {
      Weather weather =
          await _weatherRepository.getWeatherForLocation(position.latitude, position.longitude);
      await _currentLocationService.updateCurrentCity(weather.city);
    }

    List<Weather> weatherList = await _weatherRepository.getAllWeather();
    for (Weather weather in weatherList) {
      await _weatherRepository.getWeatherForCity(weather.city);
    }

    await Future.delayed(const Duration(seconds: 5));
  }
}
