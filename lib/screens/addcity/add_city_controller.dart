import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/screens/addcity/city_list_item.dart';
import 'package:sweaterweather/services/city_storage_service.dart';
import 'package:sweaterweather/services/weather_service.dart';

class AddCityController with ChangeNotifier {
  final _weatherService = WeatherService(DotEnv().env['WEATHER_API_KEY']);
  final _cityStorage = CityStorageService();
  List<City> _cities = [];

  bool isProgress = false;

  List<CityListItem> cityListItems() => _cities.map((e) => CityListItem(e)).toList();

  Future<void> findByName(String name) async {
    _cities.clear();
    if (name.isEmpty) {
      notifyListeners();
      return;
    }
    _setProgress(true);
    final result = await _weatherService.findCity(name);
    if (result.isSuccess()) {
      _cities.addAll(result.successValue);
    } else {
      print("result" + result.errorValue);
    }
    _setProgress(false);
  }

  Future<void> findByCurrentLocation() async {
    _setProgress(true);
    _cities.clear();
    Position pos = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final result = await _weatherService.getWeatherByLocation(Location(lat: pos.latitude, lon: pos.longitude));
    if (result.isSuccess()) {
      _cities.add(City(
          id: result.successValue.cityId,
          name: result.successValue.cityName,
          country: result.successValue.sys.countryCode,
          location: result.successValue.location));
    } else {
      print("result" + result.errorValue);
    }
    _setProgress(false);
  }

  Future<void> addNewCity(City city) => _cityStorage.addCity(city);

  void _setProgress(bool value) {
    isProgress = value;
    notifyListeners();
  }
}
