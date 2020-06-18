import 'package:sweaterweather/data/services/weather_service.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/location.dart';

class CityRepository {
  final WeatherService _weatherService;
  final CityStorage _cityStorage;

  CityRepository(this._weatherService, this._cityStorage);

  Future<List<City>> findCityByName(String name) async {
    final result = await _weatherService.findCity(name);
    if (result.isSuccess()) {
      return result.successValue;
    } else {
      print("result" + result.errorValue);
      return null;
    }
  }

  Future<City> findCityByLocation(Location location) async {
    final result = await _weatherService.getWeatherByLocation(location);
    if (result.isSuccess()) {
      return City(
          id: result.successValue.cityId,
          name: result.successValue.cityName,
          country: result.successValue.sys.countryCode,
          location: result.successValue.location);
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
