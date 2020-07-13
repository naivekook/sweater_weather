import 'package:sweaterweather/models/city.dart';

class CityListItem {
  City city;
  String icon;
  int temp;
  String weather;
  bool added;

  CityListItem(this.city, this.icon, this.temp, this.weather, this.added);
}
