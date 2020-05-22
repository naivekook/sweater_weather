import 'package:sweaterweather/models/location.dart';
import 'package:sweaterweather/models/rain.dart';
import 'package:sweaterweather/models/snow.dart';
import 'package:sweaterweather/models/weather_condition.dart';

class DetailedWeather {
  Location location;
  String timezone;
  int timezoneOffset;
  Current current;
  List<Hourly> hourly;
  List<Daily> daily;

  DetailedWeather(
      {this.location, this.timezone, this.timezoneOffset, this.current, this.hourly, this.daily});

  DetailedWeather.fromJson(Map<String, dynamic> json) {
    Location.fromJson(json);
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    if (json['current'] != null) {
      current = Current.fromJson(json['current']);
    }
    if (json['hourly'] != null) {
      hourly = List<Hourly>();
      json['hourly'].forEach((v) {
        hourly.add(Hourly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = List<Daily>();
      json['daily'].forEach((v) {
        daily.add(Daily.fromJson(v));
      });
    }
  }
}

class Current {
  int timestamp;
  int sunrise;
  int sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double atmosphericTemp;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  double windGust;
  List<WeatherCondition> weather;
  Rain rain;
  Snow snow;

  Current(
      {this.timestamp,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.atmosphericTemp,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.rain,
      this.snow});

  Current.fromJson(Map<String, dynamic> json) {
    timestamp = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    atmosphericTemp = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed']?.toDouble();
    windDeg = json['wind_deg'];
    windGust = json['wind_gust']?.toDouble();
    if (json['weather'] != null) {
      weather = List<WeatherCondition>();
      json['weather'].forEach((v) {
        weather.add(WeatherCondition.fromJson(v));
      });
    }
    if (json['rain'] != null) {
      rain = Rain.fromJson(json['rain']);
    }
    if (json['snow'] != null) {
      snow = Snow.fromJson(json['snow']);
    }
  }
}

class Hourly {
  int timestamp;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  int clouds;
  double windSpeed;
  int windDeg;
  List<WeatherCondition> weather;
  Rain rain;
  Snow snow;

  Hourly(
      {this.timestamp,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.clouds,
      this.windSpeed,
      this.windDeg,
      this.weather,
      this.rain,
      this.snow});

  Hourly.fromJson(Map<String, dynamic> json) {
    timestamp = json['dt'];
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like']?.toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
    clouds = json['clouds'];
    windSpeed = json['wind_speed']?.toDouble();
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weather = List<WeatherCondition>();
      json['weather'].forEach((v) {
        weather.add(WeatherCondition.fromJson(v));
      });
    }
    if (json['rain'] != null) {
      rain = Rain.fromJson(json['rain']);
    }
    if (json['snow'] != null) {
      snow = Snow.fromJson(json['snow']);
    }
  }
}

class Daily {
  int timestamp;
  int sunrise;
  int sunset;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double atmosphericTemp;
  double windSpeed;
  int windDeg;
  List<WeatherCondition> weather;
  int clouds;
  double rain;
  double snow;
  double uvi;

  Daily(
      {this.timestamp,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.atmosphericTemp,
      this.windSpeed,
      this.windDeg,
      this.weather,
      this.clouds,
      this.rain,
      this.snow,
      this.uvi});

  Daily.fromJson(Map<String, dynamic> json) {
    timestamp = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    if (json['temp'] != null) {
      temp = Temp.fromJson(json['temp']);
    }
    if (json['feels_like'] != null) {
      feelsLike = FeelsLike.fromJson(json['feels_like']);
    }
    pressure = json['pressure'];
    humidity = json['humidity'];
    atmosphericTemp = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weather = List<WeatherCondition>();
      json['weather'].forEach((v) {
        weather.add(WeatherCondition.fromJson(v));
      });
    }
    clouds = json['clouds'];
    rain = json['rain'];
    snow = json['snow'];
    uvi = json['uvi']?.toDouble();
  }
}

class Temp {
  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day']?.toDouble();
    min = json['min']?.toDouble();
    max = json['max']?.toDouble();
    night = json['night']?.toDouble();
    eve = json['eve']?.toDouble();
    morn = json['morn']?.toDouble();
  }
}

class FeelsLike {
  double day;
  double night;
  double eve;
  double morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day']?.toDouble();
    night = json['night']?.toDouble();
    eve = json['eve']?.toDouble();
    morn = json['morn']?.toDouble();
  }
}
