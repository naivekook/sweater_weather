import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sweaterweather/data/services/dto/city_with_weather_dto.dart';
import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/models/network_result.dart';
import 'package:sweaterweather/models/weather.dart';

class WeatherService {
  static const String URL = 'http://api.openweathermap.org/data/2.5';
  final String _apiKey;

  WeatherService(this._apiKey);

  Future<NetworkResult<List<FindCityResponseDto>, String>> findCityByName(
      String name) async {
    final response =
        await http.get(URL + '/find?q=$name&type=like&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseFindCity, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<List<FindCityResponseDto>, String>> findCityByLocation(
      double lat, double lon) async {
    final response = await http
        .get(URL + '/find?lat=$lat&lon=$lon&type=like&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseFindCity, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<Weather, String>> getWeatherByCityId(int cityId) async {
    final response =
        await http.get(URL + '/weather?id=$cityId&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseWeather, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<Weather, String>> getWeatherByLocation(
      double lat, double lon) async {
    final response = await http
        .get(URL + '/weather?lat=$lat&lon=$lon&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseWeather, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  Future<NetworkResult<DetailedWeather, String>> getWeatherOneCall(
      double lat, double lon) async {
    final response = await http
        .get(URL + '/onecall?lat=$lat&lon=$lon&units=metric&appid=$_apiKey');

    if (response.statusCode == 200) {
      final result = await compute(_parseOneCall, response.body);
      return NetworkResult(successValue: result);
    } else {
      return NetworkResult(errorValue: getErrorMessage(response));
    }
  }

  String getErrorMessage(http.Response response) {
    return "code: ${response.statusCode}, body: ${response.body}";
  }
}

List<FindCityResponseDto> _parseFindCity(String responseBody) {
  final Map<String, dynamic> json = jsonDecode(responseBody);
  return json['list']
      .map<FindCityResponseDto>((json) => FindCityResponseDto.fromJson(json))
      .toList();
}

Weather _parseWeather(String responseBody) {
  final Map<String, dynamic> json = jsonDecode(responseBody);
  return Weather.fromJson(json);
}

DetailedWeather _parseOneCall(String responseBody) {
  final Map<String, dynamic> json = jsonDecode(responseBody);
  return DetailedWeather.fromJson(json);
}
