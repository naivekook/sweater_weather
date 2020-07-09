import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/main.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/city_with_weather.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_item.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class AddCityController with ChangeNotifier {
  final CityRepository _cityRepository = getIt.get();

  List<CityListItem> listItems = [];
  bool isProgress = false;

  Future<void> findByName(String name) async {
    listItems.clear();
    if (name.isEmpty) {
      notifyListeners();
      return;
    }
    _setProgress(true);
    final cities = await _cityRepository.findCityByName(name);
    listItems.addAll(_mapToItem(cities));
    _setProgress(false);
  }

  Future<void> findByCurrentLocation() async {
    _setProgress(true);
    listItems.clear();
    Position pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final cities =
        await _cityRepository.findCityByLocation(pos.latitude, pos.longitude);
    listItems.addAll(_mapToItem(cities));
    _setProgress(false);
  }

  Future<void> addNewCity(City city) => _cityRepository.saveCity(city);

  void _setProgress(bool value) {
    isProgress = value;
    notifyListeners();
  }

  List<CityListItem> _mapToItem(List<CityWithWeather> cities) {
    return cities
        .map((e) => CityListItem(
            e.city,
            WeatherIconUtils.iconCodeToPath(e.icon),
            e.temp.toInt(),
            e.weather,
            false))
        .toList();
  }
}
