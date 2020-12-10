import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweaterweather/models/detailed_weather.dart';

class DetailedWeatherStorage {
  static const _DETAILED_WEATHER_KEY = 'saved_detailed_weather';

  Future<List<DetailedWeather>> getWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_DETAILED_WEATHER_KEY);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => DetailedWeather.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveWeather(List<DetailedWeather> items) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_DETAILED_WEATHER_KEY, jsonEncode(items.map((e) => e.toJson()).toList()));
  }
}
