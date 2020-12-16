
import 'package:hive/hive.dart';
import 'package:sweaterweather/models/hive/city.dart';

class CityStorage {
  static const _CITY_LIST_KEY = 'saved_cities';

  Future<List<City>> get() async {
    final box = await Hive.openBox(_CITY_LIST_KEY);
    return box.values.toList().cast<City>();
  }

  Future<void> save(List<City> cities) async {
    final box = await Hive.openBox(_CITY_LIST_KEY);
    cities.forEach((element) {
      box.put(element.id, element);
    });
  }
}
