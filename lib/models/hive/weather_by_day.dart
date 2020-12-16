import 'package:hive/hive.dart';

part 'weather_by_day.g.dart';

@HiveType(typeId: 5)
class WeatherByDay {
  @HiveField(0)
  final int timestamp;

  @HiveField(1)
  final double tempDay;

  @HiveField(2)
  final double tempNight;

  @HiveField(3)
  final String icon;

  WeatherByDay(this.timestamp, this.tempDay, this.tempNight, this.icon);
}
