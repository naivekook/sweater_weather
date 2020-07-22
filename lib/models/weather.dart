class Weather {
  int timestamp;
  int cityId;
  double lat;
  double lon;
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

  Weather(
      this.timestamp,
      this.cityId,
      this.lat,
      this.lon,
      this.temp,
      this.tempFeelsLike,
      this.description,
      this.icon,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.cloudiness,
      this.sunrise,
      this.sunset);

  Weather.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    cityId = json['city_id'];
    lat = json['lat'].toDouble();
    lon = json['lon'].toDouble();
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
    data['city_id'] = cityId;
    data['lat'] = lat;
    data['lon'] = lon;
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
