import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweaterweather/data/services/weather_service.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/ui/screens/weather/weather_grid_item.dart';

class WeatherController with ChangeNotifier {
  final City _city;
  final _weatherService = WeatherService(DotEnv().env['WEATHER_API_KEY']);

  DetailedWeather _weather;
  bool isError = false;
  String errorMessage;

  WeatherController(this._city) {
    _weatherService.getWeatherOneCall(_city.location).then((value) {
      isError = value.isError();
      if (value.isSuccess()) {
        _weather = value.successValue;
      } else {
        errorMessage = value.errorValue;
        print(errorMessage);
      }
      notifyListeners();
    });
  }

  List<WeatherGridItem> getGridItems() {
    List<WeatherGridItem> result = [];
    if (_weather != null) {
      result.add(WeatherGridItem('Wind', '${_weather.current.windSpeed} meter/sec'));
      result.add(WeatherGridItem('Humidity', '${_weather.current.humidity}%'));
      result.add(WeatherGridItem('Cloudiness', '${_weather.current.clouds ?? '-'}%'));
      result.add(WeatherGridItem('Morning', '${_weather.daily.first.temp.morn}°'));
      result.add(WeatherGridItem('Day', '${_weather.daily.first.temp.day}°'));
      result.add(WeatherGridItem('Night', '${_weather.daily.first.temp.night}°'));
    }
    return result;
  }
}
