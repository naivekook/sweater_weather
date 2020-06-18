import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweaterweather/models/weather_extended.dart';

class WeatherStorage {
  static const _WEATHER_KEY = 'saved_weather';

  Future<List<WeatherExtended>> getWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_WEATHER_KEY);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => WeatherExtended.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveWeather(List<WeatherExtended> items) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_WEATHER_KEY, jsonEncode(items.map((e) => e.toJson()).toList()));
  }
}
