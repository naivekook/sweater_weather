class WeatherCondition {
  int id;
  String main;
  String description;
  String icon;

  WeatherCondition({this.id, this.main, this.description, this.icon});

  WeatherCondition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}
