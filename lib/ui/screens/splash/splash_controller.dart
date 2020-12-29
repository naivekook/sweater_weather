import 'package:flutter/foundation.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/services/weather_updater_service.dart';

class SplashController with ChangeNotifier {
  final _starter = AppStarter();

  bool hasError = false;
  bool readyToGo = false;

  SplashController() {
    _starter.init().then((value) => refreshWeather());
  }

  Future refreshWeather() async {
    _resetScreen();
    try {
      await getIt.get<WeatherUpdaterService>().updateAllWeather();
      readyToGo = true;
    } catch (ex) {
      hasError = true;
    }
    notifyListeners();
  }

  _resetScreen() {
    hasError = false;
    readyToGo = false;
    notifyListeners();
  }
}
