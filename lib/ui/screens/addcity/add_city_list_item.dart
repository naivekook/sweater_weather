import 'package:sweaterweather/models/city.dart';

class CityListItem {
  final City city;
  final String icon;
  final int temp;
  final String weather;
  final bool added;

  CityListItem(this.city, this.icon, this.temp, this.weather, this.added);
}
