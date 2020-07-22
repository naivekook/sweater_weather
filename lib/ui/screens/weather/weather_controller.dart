import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/main.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/weather.dart';
import 'package:sweaterweather/ui/screens/weather/weather_grid_item.dart';
import 'package:sweaterweather/ui/screens/weather/weather_header_info.dart';

class WeatherController with ChangeNotifier {
  final City _city;
  final WeatherRepository _weatherRepository = getIt.get();

  Weather weather;
  bool isError = false;
  String errorMessage;

  WeatherController(this._city) {
    _weatherRepository.getWeatherForLocation(_city.lat, _city.lon).then((value) {
      weather = value;
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
    if (weather != null) {
      result.add(WeatherGridItem('Wind speed', '${weather.windSpeed ?? 'N/A'} meter/sec'));
      result.add(WeatherGridItem('Humidity', '${weather.humidity ?? 'N/A'}%'));
      result.add(WeatherGridItem('Cloudiness', '${weather.cloudiness ?? 'N/A'}%'));
      result.add(WeatherGridItem('Pressure', '${weather.pressure ?? 'N/A'} hPa'));

      String sunriseTime = 'N/A';
      String sunsetTime = 'N/A';
      if (weather.sunrise != null) {
        sunriseTime = DateFormat(DateFormat.HOUR24_MINUTE)
            .format(DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000));
      }
      if (weather.sunset != null) {
        sunsetTime = DateFormat(DateFormat.HOUR24_MINUTE)
            .format(DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000));
      }

      result.add(WeatherGridItem('Sunrise', sunriseTime));
      result.add(WeatherGridItem('Sunset', sunsetTime));
    }
    return result;
  }
}
