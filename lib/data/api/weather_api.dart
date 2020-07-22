import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sweaterweather/data/api/dto/find_city_dto.dart';
import 'package:sweaterweather/data/api/dto/weather_dto.dart';
import 'package:sweaterweather/models/network_result.dart';

class WeatherApi {
  static const String URL = 'http://api.openweathermap.org/data/2.5';
  final String _apiKey;

  WeatherApi(this._apiKey);

  Future<NetworkResult<List<FindCityDto>, String>> findCityByName(String name) async {
    final response = await http.get(URL + '/find?q=$name&type=like&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseFindCity, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<List<FindCityDto>, String>> findCityByLocation(
      double lat, double lon) async {
    final response =
        await http.get(URL + '/find?lat=$lat&lon=$lon&type=like&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseFindCity, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<WeatherDto, String>> getWeatherByCityId(int cityId) async {
    final response = await http.get(URL + '/weather?id=$cityId&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseWeather, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<WeatherDto, String>> getWeatherByLocation(double lat, double lon) async {
    final response = await http.get(URL + '/weather?lat=$lat&lon=$lon&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseWeather, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  String getErrorMessage(http.Response response) {
    return "code: ${response.statusCode}, body: ${response.body}";
  }
}

List<FindCityDto> _parseFindCity(String responseBody) {
  final Map<String, dynamic> json = jsonDecode(responseBody);
  return json['list'].map<FindCityDto>((json) => FindCityDto.fromJson(json)).toList();
}

WeatherDto _parseWeather(String responseBody) {
  final Map<String, dynamic> json = jsonDecode(responseBody);
  return WeatherDto.fromJson(json);
}
