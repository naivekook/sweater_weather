import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sweaterweather/models/city_with_palette.dart';
import 'package:sweaterweather/ui/screens/about/about_screen.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_screen.dart';
import 'package:sweaterweather/ui/screens/home/home_screen.dart';
import 'package:sweaterweather/ui/screens/weather/weather_screen.dart';

class AppRouter {
  static const String HOME = '/';
  static const String ADD_CITY = '/addcity';
  static const String WEATHER = '/weather';
  static const String ABOUT = '/about';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      case ADD_CITY:
        return CupertinoPageRoute(builder: (context) => AddCityScreen());
      case WEATHER:
        final cityWithPalette = settings.arguments as CityWithPalette;
        return CupertinoPageRoute(builder: (context) => WeatherScreen(cityWithPalette));
      case ABOUT:
        return CupertinoPageRoute(builder: (context) => AboutScreen());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
