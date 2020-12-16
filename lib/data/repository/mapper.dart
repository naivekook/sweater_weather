import 'package:sweaterweather/data/api/dto/detailed_weather_dto.dart';
import 'package:sweaterweather/data/api/dto/find_city_dto.dart';
import 'package:sweaterweather/data/api/dto/weather_dto.dart';
import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/hive/weather.dart';
import 'package:sweaterweather/models/hive/weather_by_day.dart';
import 'package:sweaterweather/models/hive/weather_by_hour.dart';
import 'package:sweaterweather/models/hive/weather_details.dart';
import 'package:sweaterweather/utils/country_name_finder.dart';

class Mapper {
  final countryNameFinder = CountryNameFinder();

  Future<List<Weather>> mapFindCityResponse(List<FindCityDto> dtos) async {
    List<Weather> result = [];
    for (FindCityDto dto in dtos) {
      final countryName = await countryNameFinder.find(dto.countryCode);
      final city = City(dto.cityId, dto.cityName, countryName, dto.countryCode, dto.lat, dto.lon);
      final weather = Weather(
          dto.dt,
          dto.temp,
          dto.feelsLike,
          dto.weatherDescription,
          dto.weatherIcon,
          dto.pressure,
          dto.humidity,
          dto.windSpeed,
          dto.cloudiness,
          null,
          null,
          city);
      result.add(weather);
    }
    return result;
  }

  Future<Weather> mapWeatherResponse(WeatherDto dto) async {
    final countryName = await countryNameFinder.find(dto.sys.country);
    final city = City(dto.id, dto.name, countryName, dto.sys.country, dto.coord.lat, dto.coord.lon);
    return Weather(
        dto.dt,
        dto.main.temp,
        dto.main.feelsLike,
        dto.weatherCondition[0].description,
        dto.weatherCondition[0].icon,
        dto.main.pressure,
        dto.main.humidity,
        dto.wind?.speed,
        dto.clouds?.all,
        dto.sys?.sunrise,
        dto.sys?.sunset,
        city);
  }

  Future<WeatherDetails> mapDetailedWeatherResponse(DetailedWeatherDto dto, City city) async {
    List<WeatherByHour> weatherByHour =
        dto.hourly.map((e) => WeatherByHour(e.dt, e.temp, e.weatherCondition[0].icon)).toList();
    List<WeatherByDay> weatherByDay = dto.daily
        .map((e) => WeatherByDay(e.dt, e.temp.day, e.temp.night, e.weatherCondition[0].icon))
        .toList();
    return WeatherDetails(
        weatherByHour, weatherByDay, dto.current.uvi.toInt(), dto.current.windDeg, city);
  }
}
