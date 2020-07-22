import 'package:sweaterweather/data/api/dto/find_city_dto.dart';
import 'package:sweaterweather/data/api/dto/weather_dto.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/city_with_weather.dart';
import 'package:sweaterweather/models/weather.dart';
import 'package:sweaterweather/utils/country_name_finder.dart';

class Mapper {
  final countryNameFinder = CountryNameFinder();

  Future<List<CityWithWeather>> mapFindCityResponse(List<FindCityDto> dtos) async {
    List<CityWithWeather> result = [];
    for (FindCityDto dto in dtos) {
      final countryName = await countryNameFinder.find(dto.countryCode);
      final city = City(dto.cityId, dto.cityName, countryName, dto.countryCode, dto.lat, dto.lon);
      final weather = Weather(
          dto.dt,
          dto.cityId,
          dto.lat,
          dto.lon,
          dto.temp,
          dto.feelsLike,
          dto.weatherDescription,
          dto.weatherIcon,
          dto.pressure,
          dto.humidity,
          dto.windSpeed,
          dto.cloudiness,
          null,
          null);
      result.add(CityWithWeather(city, weather));
    }
    return result;
  }

  Weather mapWeatherResponse(WeatherDto dto) {
    return Weather(
        dto.dt,
        dto.id,
        dto.coord.lat,
        dto.coord.lon,
        dto.main.temp,
        dto.main.feelsLike,
        dto.weather[0].description,
        dto.weather[0].icon,
        dto.main.pressure,
        dto.main.humidity,
        dto.wind?.speed,
        dto.clouds?.all,
        dto.sys?.sunrise,
        dto.sys?.sunset);
  }
}
