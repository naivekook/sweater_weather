import 'dart:async';

import 'package:flutter/widgets.dart';

class WeatherIconLoader extends StatefulWidget {
  final _imageList = [
    'clear_sky_day.png',
    'few_clouds_day.png',
    'mist_day.png',
    'rain_day.png',
    'scattered_clouds_day.png',
    'shower_rain_day.png',
    'snow_day.png',
    'thunderstorm_day.png',
    'broken_clouds_day.png'
  ];

  @override
  _WeatherIconLoaderState createState() => _WeatherIconLoaderState();
}

class _WeatherIconLoaderState extends State<WeatherIconLoader> {
  int _pos = 0;
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _pos = (_pos + 1) % widget._imageList.length;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _pos = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/illustrations/${widget._imageList[_pos]}',
        width: 75,
        height: 75,
      ),
    );
  }
}
