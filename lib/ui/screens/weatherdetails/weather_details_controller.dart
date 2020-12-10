import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/data/repository/detailed_weather_repository.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/city_with_palette.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/models/palette.dart';
import 'package:sweaterweather/ui/screens/weather/weather_grid_item.dart';
import 'package:sweaterweather/ui/screens/weatherdetails/weather_details_day_item.dart';
import 'package:sweaterweather/ui/screens/weatherdetails/weather_details_hour_item.dart';
import 'package:sweaterweather/utils/day_night_palette.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class WeatherDetailsController with ChangeNotifier {
  final DayNightPalette _dayNightPalette = getIt.get();
  final DetailedWeatherRepository _detailedWeatherRepository = getIt.get();

  City city;
  DetailedWeather detailedWeather;
  Palette palette;
  bool inProgress;
  bool isError = false;
  String errorMessage;

  List<WeatherDetailsHourItem> weatherHourItems = [];
  List<WeatherDetailsDayItem> weatherDayItems = [];
  List<WeatherGridItem> weatherAdditionalItems = [];

  WeatherDetailsController(CityWithPalette cityWithPalette) {
    city = cityWithPalette.city;
    palette = cityWithPalette.palette;
    inProgress = true;
    notifyListeners();
    _detailedWeatherRepository.getWeatherForCity(city).then((value) {
      inProgress = false;
      detailedWeather = value;
      palette = _dayNightPalette.getPalette(detailedWeather.weather);
      _updateModels();
      notifyListeners();
    });
  }

  void _updateModels() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    weatherHourItems = detailedWeather.weatherByHour
        .where((element) => element.dt * 1000 <= today.millisecondsSinceEpoch)
        .map((e) => WeatherDetailsHourItem(
            '${e.temp.toInt()}°',
            WeatherIconUtils.codeToImage(e.icon),
            DateFormat(DateFormat.HOUR24_MINUTE)
                .format(DateTime.fromMillisecondsSinceEpoch(e.dt * 1000)),
            palette.primaryColor,
            palette.secondaryColor))
        .toList();
    weatherDayItems = detailedWeather.weatherByDay
        .map((e) => WeatherDetailsDayItem(
            DateFormat('EEEE, d').format(DateTime.fromMillisecondsSinceEpoch(e.dt * 1000)),
            WeatherIconUtils.codeToImage(e.icon),
            '${e.tempDay.toInt()}°',
            '${e.tempNight.toInt()}°',
            palette.primaryColor))
        .toList();
    weatherAdditionalItems = _getGridItems();
  }

  List<WeatherGridItem> _getGridItems() {
    List<WeatherGridItem> result = [];
    if (detailedWeather != null) {
      String sunriseTime = 'N/A';
      String sunsetTime = 'N/A';
      if (detailedWeather.weather.sunrise != null) {
        sunriseTime = DateFormat(DateFormat.HOUR24_MINUTE)
            .format(DateTime.fromMillisecondsSinceEpoch(detailedWeather.weather.sunrise * 1000));
      }
      if (detailedWeather.weather.sunset != null) {
        sunsetTime = DateFormat(DateFormat.HOUR24_MINUTE)
            .format(DateTime.fromMillisecondsSinceEpoch(detailedWeather.weather.sunset * 1000));
      }

      result.add(
          WeatherGridItem('Wind speed', '${detailedWeather.weather.windSpeed ?? 'N/A'} meter/sec'));
      result.add(WeatherGridItem('Sunrise', sunriseTime));
      result.add(WeatherGridItem('Humidity', '${detailedWeather.weather.humidity ?? 'N/A'}%'));
      result
          .add(WeatherGridItem('Wind direction', _windDirectionToText(detailedWeather.windDegree)));

      result.add(WeatherGridItem('Pressure', '${detailedWeather.weather.pressure ?? 'N/A'} hPa'));
      result.add(WeatherGridItem('Sunset', sunsetTime));
      result.add(WeatherGridItem('Cloudiness', '${detailedWeather.weather.cloudiness ?? 'N/A'}%'));
      result.add(WeatherGridItem('UV index', '${detailedWeather.uvi ?? 'N/A'}'));
    }
    return result;
  }

  String _windDirectionToText(int angle) {
    if (angle == null) {
      return 'N/A';
    } else {
      return '${_getCardinalDirection(angle)} ($angle degree)';
    }
  }

  String _getCardinalDirection(int angle) {
    const directions = ['↑ N', '↗ NE', '→ E', '↘ SE', '↓ S', '↙ SW', '← W', '↖ NW'];
    return directions[(angle / 45).round() % 8];
  }
}
