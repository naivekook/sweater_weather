import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sweaterweather/data/api/dto/find_city_dto.dart';
import 'package:sweaterweather/data/api/dto/weather_dto.dart';
import 'package:sweaterweather/models/custom_exceptions.dart';

class WeatherApi {
  static const String URL = 'http://api.openweathermap.org/data/2.5';
  final String _apiKey;

  WeatherApi(this._apiKey);

  Future<List<FindCityDto>> findCityByName(String name) async {
    final response = await _makeCall('$URL/find?q=$name&type=like&units=metric&appid=$_apiKey');
    return await compute(_parseFindCity, response.body);
  }

  Future<List<FindCityDto>> findCityByLocation(double lat, double lon) async {
    final response =
        await _makeCall('$URL/find?lat=$lat&lon=$lon&type=like&units=metric&appid=$_apiKey');
    return await compute(_parseFindCity, response.body);
  }

  Future<WeatherDto> getWeatherByCityId(int cityId) async {
    final response = await _makeCall('$URL/weather?id=$cityId&units=metric&appid=$_apiKey');
    return await compute(_parseWeather, response.body);
  }

  Future<WeatherDto> getWeatherByLocation(double lat, double lon) async {
    final response = await _makeCall('$URL/weather?lat=$lat&lon=$lon&units=metric&appid=$_apiKey');
    return await compute(_parseWeather, response.body);
  }

  Future<http.Response> _makeCall(String url) async {
    try {
      final response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          return response;
        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        default:
          throw FetchDataException(
              'Error occurred while communication with server with StatusCode : ${response.statusCode}');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
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
