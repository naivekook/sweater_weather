import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/weather.dart';

class CityWithWeather {
  final City city;
  final Weather weather;

  CityWithWeather(this.city, this.weather);
}
