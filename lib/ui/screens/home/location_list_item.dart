import 'package:sweaterweather/models/city.dart';

class LocationListItem {
  City city;
  String weatherDescription;
  int temp;
  String image;

  LocationListItem(this.city, this.weatherDescription, this.temp, this.image);
}
