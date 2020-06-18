import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/models/weather.dart';

class WeatherExtended {
  Location location;
  Weather weather;

  WeatherExtended({this.location, this.weather});

  WeatherExtended.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    weather = Weather.fromJson(json['weather']);
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['location'] = location.toJson();
    data['weather'] = weather.toJson();
    return data;
  }
}
