import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/services/weather_service.dart';

class AddCityController with ChangeNotifier {
  final _weatherService = WeatherService(DotEnv().env['WEATHER_API_KEY']);
  List<City> _cities = [];

  bool isProgress = false;

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
      print("result" + result.successValue.toString());
    } else {
      print("result" + result.errorValue);
    }
    _setProgress(false);
  }

  Future<void> findByCurrentLocation() async {
    _setProgress(true);
    _cities.clear();
    Position position =
        await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final result = await _weatherService
        .getWeatherByLocation(Location(lat: position.latitude, lon: position.longitude));
    if (result.isSuccess()) {
      _cities.add(City(
          id: result.successValue.cityId,
          name: result.successValue.cityName,
          country: result.successValue.sys.countryCode,
          location: result.successValue.location));
      print("result" + result.successValue.toString());
    } else {
      print("result" + result.errorValue);
    }
    _setProgress(false);
  }

  List<Widget> cityTiles() => _cities
      .map((city) => ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'http://openweathermap.org/images/flags/${city.country.toLowerCase()}.png'),
              ],
            ),
            title: Text('${city.name}, ${city.country}'),
            onTap: () {
              print('ListTile tapped');
            },
          ))
      .toList();

  void _setProgress(bool value) {
    isProgress = value;
    notifyListeners();
  }
}
