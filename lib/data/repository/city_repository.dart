import 'package:sweaterweather/data/repository/mapper.dart';
import 'package:sweaterweather/data/services/weather_service.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/city_with_weather.dart';

class CityRepository {
  final WeatherService _weatherService;
  final CityStorage _cityStorage;
  final mapper = Mapper();

  CityRepository(this._weatherService, this._cityStorage);

  Future<List<CityWithWeather>> findCityByName(String name) async {
    final result = await _weatherService.findCityByName(name);
    if (result.isSuccess()) {
      return await mapper.mapFindCityResponse(result.successValue);
    } else {
      print("result" + result.errorValue);
      return null;
    }
  }

  Future<List<CityWithWeather>> findCityByLocation(
      double lat, double lon) async {
    final result = await _weatherService.findCityByLocation(lat, lon);
    if (result.isSuccess()) {
      return await mapper.mapFindCityResponse(result.successValue);
    } else {
      print("result" + result.errorValue);
      return null;
    }
  }

  Future<void> saveCity(City city) async {
    final List<City> cities = await _cityStorage.get();
    if (!cities.contains(city)) {
      cities.add(city);
      await _cityStorage.save(cities);
    }
  }

  Future<void> removeCity(City city) async {
    final List<City> cities = await _cityStorage.get();
    if (cities.contains(city)) {
      cities.remove(city);
      await _cityStorage.save(cities);
    }
  }

  Future<List<City>> getCities() => _cityStorage.get();
}
