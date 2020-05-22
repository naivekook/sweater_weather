class Snow {
  double d1h;
  double d3h;

  Snow({this.d1h, this.d3h});

  Snow.fromJson(Map<String, dynamic> json) {
    d1h = json['1h'].toDouble();
    d3h = json['3h']?.toDouble();
  }
}
