import 'package:flutter/foundation.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/main.dart';
import 'package:sweaterweather/ui/screens/home/location_list_item.dart';

class HomeController with ChangeNotifier {
  final CityRepository _cityRepository = getIt.get();

  List<LocationListItem> cities = [];

  HomeController() {
    getLocation();
  }

  Future<void> getLocation() async {
    final savedCities = await _cityRepository.getCities();
    cities = savedCities.map((city) => LocationListItem(city.name, "cloudy", 15, "")).toList();
    notifyListeners();
  }
}
