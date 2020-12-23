import 'package:hive/hive.dart';

part 'weather_by_hour.g.dart';

@HiveType(typeId: 4)
class WeatherByHour {
  @HiveField(0)
  final int timestamp;

  @HiveField(1)
  final double temp;

  @HiveField(2)
  final String icon;

  WeatherByHour(this.timestamp, this.temp, this.icon);
}
