import 'package:sweaterweather/models/city.dart';

class CityWithWeather {
  final City city;
  final double temp;
  final String weather;
  final String icon;

  CityWithWeather(this.city, this.temp, this.weather, this.icon);
}
