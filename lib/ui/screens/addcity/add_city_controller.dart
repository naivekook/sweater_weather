import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/main.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_item.dart';

class AddCityController with ChangeNotifier {
  final CityRepository _cityRepository = getIt.get();
  List<City> _cities = [];

  bool isProgress = false;

  List<CityListItem> cityListItems() =>
      _cities.map((e) => CityListItem(e)).toList();

  Future<void> findByName(String name) async {
    _cities.clear();
    if (name.isEmpty) {
      notifyListeners();
      return;
    }
    _setProgress(true);
    final result = await _cityRepository.findCityByName(name);
    _cities.clear();
    _cities.addAll(result);
    _setProgress(false);
  }

  Future<void> findByCurrentLocation() async {
    _setProgress(true);
    _cities.clear();
    Position pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final result = await _cityRepository
        .findCityByLocation(Location(lat: pos.latitude, lon: pos.longitude));
    _cities.clear();
    _cities.add(result);
    _setProgress(false);
  }

  Future<void> addNewCity(City city) => _cityRepository.saveCity(city);

  void _setProgress(bool value) {
    isProgress = value;
    notifyListeners();
  }
}
