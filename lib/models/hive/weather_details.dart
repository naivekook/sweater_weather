import 'package:hive/hive.dart';
import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/hive/weather_by_day.dart';
import 'package:sweaterweather/models/hive/weather_by_hour.dart';

part 'weather_details.g.dart';

@HiveType(typeId: 3)
class WeatherDetails {
  @HiveField(0)
  final List<WeatherByHour> weatherByHour;

  @HiveField(1)
  final List<WeatherByDay> weatherByDay;

  @HiveField(2)
  final int uvi;

  @HiveField(3)
  final int windDegree;

  @HiveField(4)
  final City city;

  WeatherDetails(this.weatherByHour, this.weatherByDay, this.uvi, this.windDegree, this.city);
}
