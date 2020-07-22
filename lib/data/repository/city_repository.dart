import 'package:sweaterweather/data/repository/mapper.dart';
import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/city_with_weather.dart';

class CityRepository {
  final WeatherApi _weatherApi;
  final CityStorage _cityStorage;
  final _mapper = Mapper();

  CityRepository(this._weatherApi, this._cityStorage);

  Future<List<CityWithWeather>> findCityByName(String name) async {
    final result = await _weatherApi.findCityByName(name);
    if (result.isSuccess()) {
      return await _mapper.mapFindCityResponse(result.successValue);
    } else {
      print("result" + result.errorValue);
      return null;
    }
  }

  Future<List<CityWithWeather>> findCityByLocation(
      double lat, double lon) async {
    final result = await _weatherApi.findCityByLocation(lat, lon);
    if (result.isSuccess()) {
      return await _mapper.mapFindCityResponse(result.successValue);
    } else {
      print("result" + result.errorValue);
      return null;
    }
  }

  Future<void> saveCity(City city) async {
    final List<City> cities = await _cityStorage.get();
    if (!cities.any((element) => element.id == city.id)) {
      cities.add(city);
      await _cityStorage.save(cities);
    }
  }

  Future<void> removeCity(City city) async {
    final List<City> cities = await _cityStorage.get();
    if (cities.any((element) => element.id == city.id)) {
      cities.removeWhere((element) => element.id == city.id);
      await _cityStorage.save(cities);
    }
  }

  Future<List<City>> getCities() => _cityStorage.get();
}
