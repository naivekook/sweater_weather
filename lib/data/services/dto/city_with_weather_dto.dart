class FindCityResponseDto {
  int cityId;
  String cityName;
  String countryCode;
  double lat;
  double lon;
  double temp;
  String weatherDescription;
  String weatherIcon;

  FindCityResponseDto(this.cityId, this.cityName, this.countryCode, this.lat,
      this.lon, this.temp, this.weatherDescription, this.weatherIcon);

  FindCityResponseDto.fromJson(Map<String, dynamic> json) {
    cityId = json['id'];
    cityName = json['name'];
    countryCode = json['sys']['country'];
    lat = json['coord']['lat'].toDouble();
    lon = json['coord']['lon'].toDouble();
    temp = json['main']['temp'].toDouble();
    weatherDescription = json['weather'][0]['description'];
    weatherIcon = json['weather'][0]['icon'];
  }
}
