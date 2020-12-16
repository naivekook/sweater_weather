import 'package:hive/hive.dart';

part 'city.g.dart';

@HiveType(typeId: 1)
class City {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String countryName;

  @HiveField(3)
  final String countryCode;

  @HiveField(4)
  final double lat;

  @HiveField(5)
  final double lon;

  City(this.id, this.name, this.countryName, this.countryCode, this.lat, this.lon);
}
