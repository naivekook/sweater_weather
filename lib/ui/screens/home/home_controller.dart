import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/weather.dart';
import 'package:sweaterweather/ui/screens/home/location_list_item.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class HomeController with ChangeNotifier {
  final CityRepository _cityRepository = getIt.get();
  final WeatherRepository _weatherRepository = getIt.get();

  List<LocationListItem> weatherTiles = [];
  bool inProgress = false;

  HomeController() {
    refresh();
  }

  void refresh() async {
    if (inProgress) {
      return;
    }
    _showLoading();
    await _loadForecast();
    _hideLoading();
  }

  Future<void> _loadForecast() async {
    List<LocationListItem> tileSet = [];
    try {
      Position position =
          await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Weather weather =
          await _weatherRepository.getWeatherForLocation(position.latitude, position.longitude);
      tileSet.add(mapWeatherToTile(weather, true));
    } on PlatformException {} catch (ex, st) {
      Crashlytics.instance.recordError(ex, st);
    }

    final savedCities = await _cityRepository.getCities();
    for (City city in savedCities) {
      Weather weather = await _weatherRepository.getWeatherForCity(city);
      tileSet.add(mapWeatherToTile(weather, false));
    }
    _updateTiles(tileSet);
  }

  void _showLoading() {
    inProgress = true;
    notifyListeners();
  }

  void _hideLoading() {
    inProgress = false;
    notifyListeners();
  }

  void _updateTiles(List<LocationListItem> tiles) {
    weatherTiles.clear();
    weatherTiles.addAll(tiles);
    notifyListeners();
  }

  LocationListItem mapWeatherToTile(Weather weather, bool currentLocation) {
    return LocationListItem(weather.city, weather.description, weather.temp.toInt(),
        WeatherIconUtils.codeToIllustration(weather.icon), currentLocation);
  }
}
