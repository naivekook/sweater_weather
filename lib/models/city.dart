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

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    if (location != null) {
      data['coord'] = location.toJson();
    }
    if (country != null) {
      final data = Map<String, dynamic>();
      data['country'] = country;
      data['sys'] = data;
    }
    return data;
  }
}
