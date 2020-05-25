import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/models/rain.dart';
import 'package:sweaterweather/models/snow.dart';
import 'package:sweaterweather/models/weather_condition.dart';

class Weather {
  Location location;
  List<WeatherCondition> weather;
  Main main;
  Wind wind;
  Clouds clouds;
  Sys sys;
  Rain rain;
  Snow snow;
  int cityId;
  String cityName;
  int timezone;
  int timestamp;
  int visibility;

  Weather(
      {this.location,
      this.weather,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.timestamp,
      this.sys,
      this.timezone,
      this.cityId,
      this.cityName});

  Weather.fromJson(Map<String, dynamic> json) {
    timestamp = json['dt'];
    visibility = json['visibility'];
    timezone = json['timezone'];
    cityId = json['id'];
    cityName = json['name'];
    if (json['coord'] != null) {
      location = Location.fromJson(json['coord']);
    }
    if (json['weather'] != null) {
      weather = new List<WeatherCondition>();
      json['weather'].forEach((v) {
        weather.add(new WeatherCondition.fromJson(v));
      });
    }
    if (json['main'] != null) {
      main = Main.fromJson(json['main']);
    }
    if (json['wind'] != null) {
      wind = Wind.fromJson(json['wind']);
    }
    if (json['clouds'] != null) {
      clouds = Clouds.fromJson(json['clouds']);
    }
    if (json['rain'] != null) {
      rain = Rain.fromJson(json['rain']);
    }
    if (json['snow'] != null) {
      snow = Snow.fromJson(json['snow']);
    }
    if (json['sys'] != null) {
      sys = Sys.fromJson(json['sys']);
    }
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main({this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure, this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toDouble();
    deg = json['deg'];
    gust = json['gust']?.toDouble();
  }
}

class Clouds {
  int all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Sys {
  String countryCode;
  int sunrise;
  int sunset;

  Sys({this.countryCode, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    countryCode = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}
