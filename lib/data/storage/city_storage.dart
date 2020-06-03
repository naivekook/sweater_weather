import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweaterweather/models/city.dart';

class CityStorage {
  static const _CITY_LIST_KEY = 'saved_cities';

  Future<void> addCity(City city) async {
    final List<City> cities = await _getFromPrefs();
    if (!cities.contains(city)) {
      cities.add(city);
      await _saveToPrefs(cities);
    }
  }

  Future<void> removeCity(City city) async {
    final List<City> cities = await _getFromPrefs();
    if (cities.contains(city)) {
      cities.remove(city);
      await _saveToPrefs(cities);
    }
  }

  Future<List<City>> getCities() => _getFromPrefs();

  Future<List<City>> _getFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_CITY_LIST_KEY);
    if (json != null) {
      final List<dynamic> citiesDecoded = jsonDecode(json);
      return citiesDecoded.map((e) => City.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> _saveToPrefs(List<City> cities) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_CITY_LIST_KEY, jsonEncode(cities.map((e) => e.toJson()).toList()));
  }
}
