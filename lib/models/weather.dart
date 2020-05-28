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

  Weather({location, weather, main, visibility, wind, clouds, timestamp, sys, timezone, cityId, cityName});

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

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['dt'] = timestamp;
    data['visibility'] = visibility;
    data['timezone'] = timezone;
    data['id'] = cityId;
    data['name'] = cityName;
    if (location != null) {
      data['coord'] = location.toJson();
    }
    if (weather != null) {
      data['weather'] = weather.map((v) => v.toJson()).toList();
    }
    if (main != null) {
      data['main'] = main.toJson();
    }
    if (wind != null) {
      data['wind'] = wind.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds.toJson();
    }
    if (rain != null) {
      data['rain'] = rain.toJson();
    }
    if (snow != null) {
      data['snow'] = snow.toJson();
    }
    if (sys != null) {
      data['sys'] = sys.toJson();
    }
    return data;
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main({temp, feelsLike, tempMin, tempMax, pressure, humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({speed, deg, gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toDouble();
    deg = json['deg']?.toInt();
    gust = json['gust']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['speed'] = speed;
    if (deg != null) {
      data['deg'] = deg;
    }
    if (gust != null) {
      data['gust'] = gust;
    }
    return data;
  }
}

class Clouds {
  int all;

  Clouds({all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['all'] = all;
    return data;
  }
}

class Sys {
  String countryCode;
  int sunrise;
  int sunset;

  Sys({countryCode, sunrise, sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    countryCode = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['country'] = countryCode;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
