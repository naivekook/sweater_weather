import 'package:sweaterweather/models/city.dart';

class Weather {
  int timestamp;
  City city;
  double temp;
  double tempFeelsLike;
  String description;
  String icon;
  int pressure;
  int humidity;
  double windSpeed;
  int cloudiness;
  int sunrise;
  int sunset;

  Weather(this.timestamp, this.city, this.temp, this.tempFeelsLike, this.description, this.icon,
      this.pressure, this.humidity, this.windSpeed, this.cloudiness, this.sunrise, this.sunset);

  Weather.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    city = City.fromJson(json['city']);
    temp = json['temp'].toDouble();
    tempFeelsLike = json['temp_feels_like'].toDouble();
    description = json['weather_description'];
    icon = json['weather_icon'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    windSpeed = json['wind_speed'];
    cloudiness = json['cloudiness'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['timestamp'] = timestamp;
    data['city'] = city.toJson();
    data['temp'] = temp;
    data['temp_feels_like'] = tempFeelsLike;
    data['weather_description'] = description;
    data['weather_icon'] = icon;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['wind_speed'] = windSpeed;
    data['cloudiness'] = cloudiness;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
