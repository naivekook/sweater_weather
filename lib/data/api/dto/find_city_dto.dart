class FindCityDto {
  int cityId;
  String cityName;
  String countryCode;
  double lat;
  double lon;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  String weatherDescription;
  String weatherIcon;
  int dt;
  double windSpeed;
  int cloudiness;

  FindCityDto(this.cityId, this.cityName, this.countryCode, this.lat, this.lon, this.temp,
      this.weatherDescription, this.weatherIcon);

  FindCityDto.fromJson(Map<String, dynamic> json) {
    cityId = json['id'];
    cityName = json['name'];
    countryCode = json['sys']['country'];
    lat = json['coord']['lat'].toDouble();
    lon = json['coord']['lon'].toDouble();

    if (json['main'] != null) {
      temp = json['main']['temp'].toDouble();
      feelsLike = json['main']['feels_like'].toDouble();
      pressure = json['main']['pressure'];
      humidity = json['main']['humidity'];
    }

    weatherDescription = json['weather'][0]['description'];
    weatherIcon = json['weather'][0]['icon'];
    dt = json['dt'];

    if (json['clouds'] != null) {
      cloudiness = json['clouds']['all'];
    }

    if (json['wind'] != null) {
      windSpeed = json['wind']['speed'].toDouble();
    }
  }
}
