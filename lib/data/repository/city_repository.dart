import 'package:sweaterweather/data/api/weather_api.dart';
import 'package:sweaterweather/data/repository/mapper.dart';
import 'package:sweaterweather/data/storage/city_storage.dart';
import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/hive/weather.dart';

class CityRepository {
  final WeatherApi _weatherApi;
  final CityStorage _cityStorage;
  final _mapper = Mapper();

  CityRepository(this._weatherApi, this._cityStorage);

  Future<List<Weather>> findCityByName(String name) async {
    final result = await _weatherApi.findCityByName(name);
    return await _mapper.mapFindCityResponse(result);
  }

  Future<List<Weather>> findCityByLocation(double lat, double lon) async {
    final result = await _weatherApi.findCityByLocation(lat, lon);
    return await _mapper.mapFindCityResponse(result);
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
