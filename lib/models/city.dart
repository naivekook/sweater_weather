class City {
  int id;
  String name;
  String countryName;
  String countryCode;
  double lat;
  double lon;

  City(this.id, this.name, this.countryName, this.countryCode, this.lat,
      this.lon);

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
    lat = json['lat'] as double;
    lon = json['lon'] as double;
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['country_name'] = countryName;
    data['country_code'] = countryCode;
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }


}
