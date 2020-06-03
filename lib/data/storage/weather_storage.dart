import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/models/weather.dart';

class WeatherStorage {
  static const _WEATHER_KEY = 'saved_weather';
  static const _WEATHER_DETAILED_KEY = 'saved_detailed_weather';

  Future<void> saveWeather(Weather weather) async {
    final List<Weather> weatherList = await _getWeatherFromPrefs();
    if (!weatherList.contains(weather)) {
      weatherList.add(weather);
      await _saveWeatherToPrefs(weatherList);
    }
  }

  Future<void> removeWeather(Weather weather) async {
    final List<Weather> weatherList = await _getWeatherFromPrefs();
    if (weatherList.contains(weather)) {
      weatherList.remove(weatherList);
      await _saveWeatherToPrefs(weatherList);
    }
  }

  Future<List<Weather>> getWeather() => _getWeatherFromPrefs();

  Future<void> saveDetailedWeather(DetailedWeather weather) async {
    final List<DetailedWeather> weatherList = await _getDetailedWeatherFromPrefs();
    if (!weatherList.contains(weather)) {
      weatherList.add(weather);
      await _saveDetailedWeatherToPrefs(weatherList);
    }
  }

  Future<void> removeDetailedWeather(DetailedWeather weather) async {
    final List<DetailedWeather> weatherList = await _getDetailedWeatherFromPrefs();
    if (weatherList.contains(weather)) {
      weatherList.remove(weatherList);
      await _saveDetailedWeatherToPrefs(weatherList);
    }
  }

  Future<List<DetailedWeather>> getDetailedWeather() => _getDetailedWeatherFromPrefs();

  Future<List<Weather>> _getWeatherFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_WEATHER_KEY);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => Weather.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<DetailedWeather>> _getDetailedWeatherFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_WEATHER_DETAILED_KEY);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => DetailedWeather.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> _saveWeatherToPrefs(List<Weather> items) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_WEATHER_KEY, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  Future<void> _saveDetailedWeatherToPrefs(List<DetailedWeather> items) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_WEATHER_DETAILED_KEY, jsonEncode(items.map((e) => e.toJson()).toList()));
  }
}
