import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/models/detailed_weather_extended.dart';
import 'package:sweaterweather/models/weather.dart';
import 'package:sweaterweather/models/weather_extended.dart';

class WeatherStorage {
  static const _WEATHER_KEY = 'saved_weather';
  static const _WEATHER_DETAILED_KEY = 'saved_detailed_weather';

  Future<void> saveWeather(Weather weather) async {
    final List<WeatherExtended> weatherList = await _getWeatherFromPrefs();
    weatherList.removeWhere((element) => element.location == weather.location);
    weatherList.add(WeatherExtended(location: weather.location, weather: weather));
    await _saveWeatherToPrefs(weatherList);
  }

  Future<List<Weather>> getWeather() async {
    final items = await _getWeatherFromPrefs();
    return items.map((e) => e.weather);
  }

  Future<void> saveDetailedWeather(DetailedWeather weather) async {
    final List<DetailedWeatherExtended> weatherList = await _getDetailedWeatherFromPrefs();
    weatherList.removeWhere((element) => element.location == weather.location);
    weatherList.add(DetailedWeatherExtended(location: weather.location, weather: weather));
        await _saveDetailedWeatherToPrefs(weatherList);
  }

  Future<List<DetailedWeather>> getDetailedWeather() async {
    final items = await _getDetailedWeatherFromPrefs();
    return items.map((e) => e.weather);
  }

  Future<List<WeatherExtended>> _getWeatherFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_WEATHER_KEY);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => WeatherExtended.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<DetailedWeatherExtended>> _getDetailedWeatherFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_WEATHER_DETAILED_KEY);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => DetailedWeatherExtended.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> _saveWeatherToPrefs(List<WeatherExtended> items) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_WEATHER_KEY, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  Future<void> _saveDetailedWeatherToPrefs(List<DetailedWeatherExtended> items) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_WEATHER_DETAILED_KEY, jsonEncode(items.map((e) => e.toJson()).toList()));
  }
}
