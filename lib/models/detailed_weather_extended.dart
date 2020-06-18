import 'package:sweaterweather/models/detailed_weather.dart';
import 'package:sweaterweather/models/location.dart';

class DetailedWeatherExtended {
  Location location;
  DetailedWeather weather;

  DetailedWeatherExtended({this.location, this.weather});

  DetailedWeatherExtended.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    weather = DetailedWeather.fromJson(json['detailed_weather']);
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['location'] = location.toJson();
    data['detailed_weather'] = weather.toJson();
    return data;
  }
}
