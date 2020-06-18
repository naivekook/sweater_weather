import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sweaterweather/data/storage/weather_storage.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/models/network_result.dart';
import 'package:sweaterweather/models/weather.dart';

class WeatherService {
  static const String URL = 'http://api.openweathermap.org/data/2.5';
  final String _apiKey;
  final _weatherStorage = WeatherStorage();

  WeatherService(this._apiKey);

  Future<NetworkResult<List<City>, String>> findCity(String name) async {
    final response = await http.get(URL + '/find?q=$name&type=like&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseCities, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<Weather, String>> getWeatherByCityId(int cityId) async {
    final response = await http.get(URL + '/weather?id=$cityId&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseWeather, response.body);
      await _weatherStorage.saveWeather(result);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<Weather, String>> getWeatherByLocation(Location location) async {
    final response =
        await http.get(URL + '/weather?lat=${location.lat}&lon=${location.lon}&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseWeather, response.body);
      await _weatherStorage.saveWeather(result);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<DetailedWeather, String>> getWeatherOneCall(Location location) async {
    final response =
        await http.get(URL + '/onecall?lat=${location.lat}&lon=${location.lon}&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseOneCall, response.body);
      await _weatherStorage.saveDetailedWeather(result);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  String getErrorMessage(http.Response response) {
    return "code: ${response.statusCode}, body: ${response.body}";
  }
}

List<City> _parseCities(String responseBody) {
  final Map<String, dynamic> json = jsonDecode(responseBody);
  return json['list'].map<City>((json) => City.fromJson(json)).toList();
}

Weather _parseWeather(String responseBody) {
  final Map<String, dynamic> json = jsonDecode(responseBody);
  return Weather.fromJson(json);
}

DetailedWeather _parseOneCall(String responseBody) {
  final Map<String, dynamic> json = jsonDecode(responseBody);
  return DetailedWeather.fromJson(json);
}
