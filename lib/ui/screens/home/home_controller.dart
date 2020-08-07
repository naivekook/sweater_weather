import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/ui/screens/home/location_list_item.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class HomeController with ChangeNotifier {
  final CityRepository _cityRepository = getIt.get();
  final WeatherRepository _weatherRepository = getIt.get();

  List<LocationListItem> weatherTiles = [];

  HomeController() {
    loadForecast();
  }

  Future<void> loadForecast() async {
    weatherTiles.clear();

    try {
      Position position =
          await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final weather =
          await _weatherRepository.getWeatherForLocation(position.latitude, position.longitude);
      weatherTiles.add(LocationListItem(weather.city, weather.description, weather.temp.toInt(),
          WeatherIconUtils.codeToIllustration(weather.icon), true));
    } on PlatformException {} catch (ex, st) {
      Crashlytics.instance.recordError(ex, st);
    }

    final savedCities = await _cityRepository.getCities();
    for (City city in savedCities) {
      final weather = await _weatherRepository.getWeatherForCity(city);
      weatherTiles.add(LocationListItem(city, weather.description, weather.temp.toInt(),
          WeatherIconUtils.codeToIllustration(weather.icon), false));
    }

    notifyListeners();
  }
}
