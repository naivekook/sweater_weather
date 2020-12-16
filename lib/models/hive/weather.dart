import 'package:hive/hive.dart';
import 'package:sweaterweather/models/hive/city.dart';

part 'weather.g.dart';

@HiveType(typeId: 2)
class Weather {
  @HiveField(0)
  final int timestamp;

  @HiveField(1)
  final double temp;

  @HiveField(2)
  final double tempFeelsLike;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String icon;

  @HiveField(5)
  final int pressure;

  @HiveField(6)
  final int humidity;

  @HiveField(7)
  final double windSpeed;

  @HiveField(8)
  final int cloudiness;

  @HiveField(9)
  final int sunrise;

  @HiveField(10)
  final int sunset;

  @HiveField(11)
  final City city;

  Weather(this.timestamp, this.temp, this.tempFeelsLike, this.description, this.icon, this.pressure,
      this.humidity, this.windSpeed, this.cloudiness, this.sunrise, this.sunset, this.city);
}
