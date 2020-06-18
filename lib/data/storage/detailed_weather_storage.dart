import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweaterweather/models/detailed_weather_extended.dart';

class DetailedWeatherStorage {
  static const _WEATHER_DETAILED_KEY = 'saved_detailed_weather';

  Future<List<DetailedWeatherExtended>> getDetailedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_WEATHER_DETAILED_KEY);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => DetailedWeatherExtended.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveDetailedWeather(List<DetailedWeatherExtended> items) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_WEATHER_DETAILED_KEY, jsonEncode(items.map((e) => e.toJson()).toList()));
  }
}
