import 'location.dart';

class City {
  int id;
  String name;
  String country;
  Location location;

  City({this.id, this.name, this.country, this.location});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['sys'] != null) {
      country = json['sys']['country'];
    }
    if (json['coord'] != null) {
      location = Location.fromJson(json['coord']);
    }
  }
}
