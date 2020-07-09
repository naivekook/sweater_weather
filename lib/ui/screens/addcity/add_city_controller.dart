import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/main.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/models/weather.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_item.dart';
import 'package:sweaterweather/utils/country_codes_formatter.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class AddCityController with ChangeNotifier {
  final CityRepository _cityRepository = getIt.get();
  final WeatherRepository _weatherRepository = getIt.get();
  final countryCodesFormatter = CountryCodesFormatter();

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
    for (City city in cities) {
      final weather = await _weatherRepository.getWeatherForCity(city);
      final item = await _makeItem(city, weather);
      listItems.add(item);
    }
    _setProgress(false);
  }

  Future<void> findByCurrentLocation() async {
    _setProgress(true);
    listItems.clear();
    Position pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final city = await _cityRepository
        .findCityByLocation(Location(lat: pos.latitude, lon: pos.longitude));
    final weather = await _weatherRepository.getWeatherForCity(city);
    final item = await _makeItem(city, weather);
    listItems.add(item);
    _setProgress(false);
  }

  Future<void> addNewCity(City city) => _cityRepository.saveCity(city);

  void _setProgress(bool value) {
    isProgress = value;
    notifyListeners();
  }

  Future<CityListItem> _makeItem(City city, Weather weather) async {
    final condition = weather.weather.first;
    String name = await countryCodesFormatter.getFullName(city.country);
    return CityListItem(city, WeatherIconUtils.iconCodeToPath(condition.icon),
        weather.main.temp.toInt(), condition.description, false);
  }
}
