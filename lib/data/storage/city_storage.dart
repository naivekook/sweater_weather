import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweaterweather/models/city.dart';

class CityStorage {
  static const _CITY_LIST_KEY = 'saved_cities';

  Future<List<City>> get() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_CITY_LIST_KEY);
    if (json != null) {
      final List<dynamic> citiesDecoded = jsonDecode(json);
      return citiesDecoded.map((e) => City.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> save(List<City> cities) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_CITY_LIST_KEY, jsonEncode(cities.map((e) => e.toJson()).toList()));
  }
}
