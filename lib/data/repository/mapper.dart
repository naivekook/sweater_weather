import 'package:sweaterweather/data/services/dto/city_with_weather_dto.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/city_with_weather.dart';
import 'package:sweaterweather/utils/country_name_finder.dart';

class Mapper {
  final countryNameFinder = CountryNameFinder();

  Future<List<CityWithWeather>> mapFindCityResponse(
      List<FindCityResponseDto> dtos) async {
    List<CityWithWeather> result = [];
    for (FindCityResponseDto dto in dtos) {
      final countryName = await countryNameFinder.find(dto.countryCode);
      result.add(CityWithWeather(
          City(dto.cityId, dto.cityName, countryName, dto.countryCode, dto.lat,
              dto.lon),
          dto.temp,
          dto.weatherDescription,
          dto.weatherIcon));
    }
    return result;
  }
}
