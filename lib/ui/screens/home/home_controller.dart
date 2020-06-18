import 'package:flutter/foundation.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/ui/screens/home/location_list_item.dart';

class HomeController with ChangeNotifier {
  final _cityStorage = CityStorage();

  List<LocationListItem> cities = [];

  HomeController() {
    getLocation();
  }

  Future<void> getLocation() async {
    final savedCities = await _cityStorage.getCities();
    cities = savedCities.map((city) => LocationListItem(city.name, "cloudy", 15, "")).toList();
    notifyListeners();
  }
}
