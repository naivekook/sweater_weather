import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sweaterweather/data/repository/detailed_weather_repository.dart';
import 'package:sweaterweather/main.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/ui/screens/weather/weather_grid_item.dart';
import 'package:sweaterweather/ui/screens/weather/weather_header_info.dart';

class WeatherController with ChangeNotifier {
  final City _city;
  final DetailedWeatherRepository _weatherRepository = getIt.get();

  DetailedWeather _weather;
  bool isError = false;
  String errorMessage;

  WeatherController(this._city) {
    _weatherRepository.getWeatherForLocation(_city.location).then((value) {
      _weather = value;
      notifyListeners();
    });
  }

  WeatherHeaderInfo getHeaderInfo() {
    DateTime date = DateTime.now();
    return WeatherHeaderInfo(
        _city.name,
        '${DateFormat('MMMM').format(date)}, ${DateFormat('d').format(date)}',
        DateFormat.EEEE().format(date));
  }

  List<WeatherGridItem> getGridItems() {
    List<WeatherGridItem> result = [];
    if (_weather != null) {
      result.add(
          WeatherGridItem('Wind', '${_weather.current.windSpeed} meter/sec'));
      result.add(WeatherGridItem('Humidity', '${_weather.current.humidity}%'));
      result.add(
          WeatherGridItem('Cloudiness', '${_weather.current.clouds ?? '-'}%'));
      result.add(
          WeatherGridItem('Morning', '${_weather.daily.first.temp.morn}°'));
      result.add(WeatherGridItem('Day', '${_weather.daily.first.temp.day}°'));
      result
          .add(WeatherGridItem('Night', '${_weather.daily.first.temp.night}°'));
    }
    return result;
  }
}
