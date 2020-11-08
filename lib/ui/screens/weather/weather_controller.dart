import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/city_with_palette.dart';
import 'package:sweaterweather/models/palette.dart';
import 'package:sweaterweather/models/weather.dart';
import 'package:sweaterweather/ui/screens/weather/weather_grid_item.dart';
import 'package:sweaterweather/utils/day_night_palette.dart';

class WeatherController with ChangeNotifier {
  final WeatherRepository _weatherRepository = getIt.get();
  final DayNightPalette _dayNightPalette = getIt.get();

  City city;
  Weather weather;
  Palette palette;
  bool inProgress;
  bool isError = false;
  String errorMessage;

  WeatherController(CityWithPalette cityWithPalette) {
    city = cityWithPalette.city;
    palette = cityWithPalette.palette;
    inProgress = true;
    notifyListeners();
    _weatherRepository.getWeatherForCity(city).then((value) {
      inProgress = false;
      weather = value;
      palette = _dayNightPalette.getPalette(weather);
      notifyListeners();
    });
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
