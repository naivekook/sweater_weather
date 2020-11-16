import 'package:sweaterweather/data/api/dto/weather_condition_dto.dart';

class WeatherDto {
  CoordDto coord;
  List<WeatherConditionDto> weatherCondition;
  String base;
  MainDto main;
  int visibility;
  WindDto wind;
  CloudsDto clouds;
  int dt;
  SysDto sys;
  int timezone;
  int id;
  String name;
  int cod;

  WeatherDto(
      {this.coord,
      this.weatherCondition,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  WeatherDto.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? new CoordDto.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weatherCondition = new List<WeatherConditionDto>();
      json['weather'].forEach((v) {
        weatherCondition.add(new WeatherConditionDto.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? new MainDto.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? new WindDto.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? new CloudsDto.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? new SysDto.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }
}

class CoordDto {
  double lon;
  double lat;

  CoordDto({this.lon, this.lat});

  CoordDto.fromJson(Map<String, dynamic> json) {
    lon = json['lon'].toDouble();
    lat = json['lat'].toDouble();
  }
}

class MainDto {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  MainDto(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});

  MainDto.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }
}

class WindDto {
  double speed;
  int deg;

  WindDto({this.speed, this.deg});

  WindDto.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toDouble();
    deg = json['deg'];
  }
}

class CloudsDto {
  int all;

  CloudsDto({this.all});

  CloudsDto.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class SysDto {
  String country;
  int sunrise;
  int sunset;

  SysDto({this.country, this.sunrise, this.sunset});

  SysDto.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}
