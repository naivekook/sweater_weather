class Location {
  double lat;
  double lon;

  Location({this.lat, this.lon});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toDouble();
    lon = json['lon'].toDouble();
  }
}
