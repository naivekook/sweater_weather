import 'package:sweaterweather/models/city.dart';

class LocationListItem {
  City city;
  String weatherDescription;
  int temp;
  String image;
  bool isFromLocation;

  LocationListItem(this.city, this.weatherDescription, this.temp, this.image, this.isFromLocation);
}
