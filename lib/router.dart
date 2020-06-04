import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_screen.dart';
import 'package:sweaterweather/ui/screens/home/home_screen.dart';
import 'package:sweaterweather/ui/screens/weather/weather_screen.dart';

class Router {
  static const String HOME = '/';
  static const String ADD_CITY = '/addcity';
  static const String WEATHER = '/weather';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case ADD_CITY:
        return MaterialPageRoute(builder: (context) => AddCityScreen());
      case WEATHER:
        final city = settings.arguments as City;
        return MaterialPageRoute(builder: (context) => WeatherScreen(city));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}