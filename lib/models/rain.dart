class Rain {
  double d1h;
  double d3h;

  Rain({this.d1h, this.d3h});

  Rain.fromJson(Map<String, dynamic> json) {
    d1h = json['1h'].toDouble();
    d3h = json['3h']?.toDouble();
  }
}
