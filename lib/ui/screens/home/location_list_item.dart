import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/palette.dart';

class LocationListItem {
  City city;
  String weatherDescription;
  int temp;
  String image;
  bool isFromLocation;
  Palette palette;

  LocationListItem(
      this.city, this.weatherDescription, this.temp, this.image, this.isFromLocation, this.palette);
}
