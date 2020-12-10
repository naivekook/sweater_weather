import 'package:sweaterweather/data/api/dto/weather_condition_dto.dart';

class DetailedWeatherDto {
  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  CurrentDto current;
  List<HourlyDto> hourly;
  List<DailyDto> daily;

  DetailedWeatherDto(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.hourly,
      this.daily});

  DetailedWeatherDto.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toDouble();
    lon = json['lon'].toDouble();
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current = json['current'] != null ? new CurrentDto.fromJson(json['current']) : null;
    if (json['hourly'] != null) {
      hourly = new List<HourlyDto>();
      json['hourly'].forEach((v) {
        hourly.add(new HourlyDto.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = new List<DailyDto>();
      json['daily'].forEach((v) {
        daily.add(new DailyDto.fromJson(v));
      });
    }
  }
}

class CurrentDto {
  int dt;
  int sunrise;
  int sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  List<WeatherConditionDto> weatherCondition;

  CurrentDto(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.weatherCondition});

  CurrentDto.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'].toDouble();
    uvi = json['uvi'].toDouble();
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'].toDouble();
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weatherCondition = new List<WeatherConditionDto>();
      json['weather'].forEach((v) {
        weatherCondition.add(new WeatherConditionDto.fromJson(v));
      });
    }
  }
}

class HourlyDto {
  int dt;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  List<WeatherConditionDto> weatherCondition;
  double pop;

  HourlyDto(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.weatherCondition,
      this.pop});

  HourlyDto.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'].toDouble();
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'].toDouble();
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weatherCondition = new List<WeatherConditionDto>();
      json['weather'].forEach((v) {
        weatherCondition.add(new WeatherConditionDto.fromJson(v));
      });
    }
    pop = json['pop']?.toDouble();
  }
}

class DailyDto {
  int dt;
  int sunrise;
  int sunset;
  TempDto temp;
  FeelsLikeDto feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double windSpeed;
  int windDeg;
  List<WeatherConditionDto> weatherCondition;
  int clouds;
  double pop;
  double uvi;
  double rain;

  DailyDto(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.weatherCondition,
      this.clouds,
      this.pop,
      this.uvi,
      this.rain});

  DailyDto.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'] != null ? new TempDto.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null ? new FeelsLikeDto.fromJson(json['feels_like']) : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'].toDouble();
    windSpeed = json['wind_speed'].toDouble();
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weatherCondition = new List<WeatherConditionDto>();
      json['weather'].forEach((v) {
        weatherCondition.add(new WeatherConditionDto.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop']?.toDouble();
    uvi = json['uvi']?.toDouble();
    rain = json['rain']?.toDouble();
  }
}

class TempDto {
  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  TempDto({this.day, this.min, this.max, this.night, this.eve, this.morn});

  TempDto.fromJson(Map<String, dynamic> json) {
    day = json['day'].toDouble();
    min = json['min'].toDouble();
    max = json['max'].toDouble();
    night = json['night'].toDouble();
    eve = json['eve'].toDouble();
    morn = json['morn'].toDouble();
  }
}

class FeelsLikeDto {
  double day;
  double night;
  double eve;
  double morn;

  FeelsLikeDto({this.day, this.night, this.eve, this.morn});

  FeelsLikeDto.fromJson(Map<String, dynamic> json) {
    day = json['day'].toDouble();
    night = json['night'].toDouble();
    eve = json['eve'].toDouble();
    morn = json['morn'].toDouble();
  }
}
