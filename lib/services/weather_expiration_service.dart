import 'package:sweaterweather/models/hive/weather.dart';

class WeatherExpirationService {
  static const _TIME_DIFF_SECOND = 7200; // 2 hours

  bool isWeatherExpired(Weather weather) {
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return currentTimestamp - weather.timestamp > _TIME_DIFF_SECOND;
  }
}
