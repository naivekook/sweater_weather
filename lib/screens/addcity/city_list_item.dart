import 'package:sweaterweather/models/city.dart';

class CityListItem {
  final City city;

  String get title => '${city.name}, ${city.country}';

  String get iconUrl => 'http://openweathermap.org/images/flags/${city.country.toLowerCase()}.png';

  CityListItem(this.city);
}
