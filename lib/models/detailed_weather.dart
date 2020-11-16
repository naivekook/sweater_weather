import 'package:sweaterweather/models/weather.dart';

class DetailedWeather {
  Weather weather;
  List<HourWeather> weatherByHour;
  List<DayWeather> weatherByDay;

  DetailedWeather(this.weather, this.weatherByHour, this.weatherByDay);

  DetailedWeather.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = Weather.fromJson(json['weather']);
    }
    if (json['hourly'] != null) {
      weatherByHour = List<HourWeather>();
      json['hourly'].forEach((v) {
        weatherByHour.add(HourWeather.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      weatherByDay = List<DayWeather>();
      json['daily'].forEach((v) {
        weatherByDay.add(DayWeather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['weather'] = weather.toJson();
    if (weatherByHour != null) {
      data['hourly'] = weatherByHour.map((v) => v.toJson()).toList();
    }
    if (weatherByDay != null) {
      data['daily'] = weatherByDay.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HourWeather {
  int dt;
  double temp;
  String icon;

  HourWeather(this.dt, this.temp, this.icon);

  HourWeather.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['dt'] = dt;
    data['temp'] = temp;
    data['icon'] = icon;
    return data;
  }
}

class DayWeather {
  int dt;
  double tempDay;
  double tempNight;
  String icon;

  DayWeather(this.dt, this.tempDay, this.tempNight, this.icon);

  DayWeather.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    tempDay = json['tempDay'];
    tempNight = json['tempNight'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['dt'] = dt;
    data['tempDay'] = tempDay;
    data['tempNight'] = tempNight;
    data['icon'] = icon;
    return data;
  }
}
