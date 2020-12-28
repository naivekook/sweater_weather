import 'package:flutter/foundation.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/models/hive/weather.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_item.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class AddCityController with ChangeNotifier {
  final CityRepository _cityRepository = getIt.get();
  final WeatherRepository _weatherRepository = getIt.get();

  List<CityListItem> listItems = [];
  bool isProgress = false;

  Future findByName(String name) async {
    listItems.clear();
    if (name.isEmpty) {
      notifyListeners();
      return;
    }
    _setProgress(true);
    List<Weather> cities;
    try {
      cities = await _cityRepository.findCityByName(name);
    } catch (ex) {}
    if (cities != null && cities.length > 0) {
      final items = _mapToItem(cities);
      final savedCities = await _cityRepository.getCities();
      if (savedCities != null && savedCities.length > 0) {
        items.forEach((e) {
          e.added = savedCities.any((e2) => e2.id == e.city.id);
        });
      }
      listItems.addAll(items);
    }
    _setProgress(false);
  }

  Future itemTapped(CityListItem item) async {
    if (item.added) {
      await _cityRepository.removeCity(item.city);
      await _weatherRepository.removeWeatherForCity(item.city);
      item.added = false;
    } else {
      await _cityRepository.saveCity(item.city);
      await _weatherRepository.getWeatherForCity(item.city);
      item.added = true;
    }
    notifyListeners();
  }

  void _setProgress(bool value) {
    isProgress = value;
    notifyListeners();
  }

  List<CityListItem> _mapToItem(List<Weather> cities) {
    return cities
        .map((e) => CityListItem(
            e.city, WeatherIconUtils.codeToImage(e.icon), e.temp.toInt(), e.description, false))
        .toList();
  }
}
