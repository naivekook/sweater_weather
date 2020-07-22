import 'package:flutter/foundation.dart';
import 'package:sweaterweather/data/repository/city_repository.dart';
import 'package:sweaterweather/data/repository/weather_repository.dart';
import 'package:sweaterweather/main.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/weather.dart';
import 'package:sweaterweather/ui/screens/home/location_list_item.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class HomeController with ChangeNotifier {
  final CityRepository _cityRepository = getIt.get();
  final WeatherRepository _weatherRepository = getIt.get();

  List<LocationListItem> cities = [];

  HomeController() {
    getLocation();
  }

  Future<void> getLocation() async {
    final savedCities = await _cityRepository.getCities();
    List<Weather> weatherList = [];
    for (City city in savedCities) {
      weatherList.add(await _weatherRepository.getWeatherForCity(city));
    }
    cities = savedCities.map((city) {
      final weather = weatherList.firstWhere((element) => element.cityId == city.id);
      return LocationListItem(city, weather.description, weather.temp.toInt(),
          WeatherIconUtils.codeToIllustration(weather.icon));
    }).toList();
    notifyListeners();
  }
}
