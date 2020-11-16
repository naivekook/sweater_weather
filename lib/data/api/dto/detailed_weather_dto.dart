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
    lat = json['lat'];
    lon = json['lon'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['timezone_offset'] = this.timezoneOffset;
    if (this.current != null) {
      data['current'] = this.current.toJson();
    }
    if (this.hourly != null) {
      data['hourly'] = this.hourly.map((v) => v.toJson()).toList();
    }
    if (this.daily != null) {
      data['daily'] = this.daily.map((v) => v.toJson()).toList();
    }
    return data;
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
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weatherCondition = new List<WeatherConditionDto>();
      json['weather'].forEach((v) {
        weatherCondition.add(new WeatherConditionDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['uvi'] = this.uvi;
    data['clouds'] = this.clouds;
    data['visibility'] = this.visibility;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    if (this.weatherCondition != null) {
      data['weather'] = this.weatherCondition.map((v) => v.toJson()).toList();
    }
    return data;
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
  int pop;

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
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weatherCondition = new List<WeatherConditionDto>();
      json['weather'].forEach((v) {
        weatherCondition.add(new WeatherConditionDto.fromJson(v));
      });
    }
    pop = json['pop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['clouds'] = this.clouds;
    data['visibility'] = this.visibility;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    if (this.weatherCondition != null) {
      data['weather'] = this.weatherCondition.map((v) => v.toJson()).toList();
    }
    data['pop'] = pop;
    return data;
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
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weatherCondition = new List<WeatherConditionDto>();
      json['weather'].forEach((v) {
        weatherCondition.add(new WeatherConditionDto.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    uvi = json['uvi'];
    rain = json['rain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    if (this.temp != null) {
      data['temp'] = this.temp.toJson();
    }
    if (this.feelsLike != null) {
      data['feels_like'] = this.feelsLike.toJson();
    }
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    if (this.weatherCondition != null) {
      data['weather'] = this.weatherCondition.map((v) => v.toJson()).toList();
    }
    data['clouds'] = this.clouds;
    data['pop'] = this.pop;
    data['uvi'] = this.uvi;
    data['rain'] = this.rain;
    return data;
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
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['min'] = this.min;
    data['max'] = this.max;
    data['night'] = this.night;
    data['eve'] = this.eve;
    data['morn'] = this.morn;
    return data;
  }
}

class FeelsLikeDto {
  double day;
  double night;
  double eve;
  double morn;

  FeelsLikeDto({this.day, this.night, this.eve, this.morn});

  FeelsLikeDto.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['night'] = this.night;
    data['eve'] = this.eve;
    data['morn'] = this.morn;
    return data;
  }
}
