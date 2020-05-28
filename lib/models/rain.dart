class Rain {
  double d1h;
  double d3h;

  Rain({this.d1h, this.d3h});

  Rain.fromJson(Map<String, dynamic> json) {
    d1h = json['1h'].toDouble();
    d3h = json['3h']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['1h'] = d1h;
    if (d3h != null) {
      data['3h'] = d3h;
    }
    return data;
  }
}
