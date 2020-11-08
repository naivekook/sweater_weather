import 'package:flutter/foundation.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/models/city_with_palette.dart';
import 'package:sweaterweather/models/palette.dart';
import 'package:sweaterweather/utils/day_night_palette.dart';

class WeatherDetailsController with ChangeNotifier {
  final DayNightPalette _dayNightPalette = getIt.get();

  City city;
  Palette palette;
  bool inProgress;
  bool isError = false;
  String errorMessage;

  WeatherDetailsController(CityWithPalette cityWithPalette) {
    city = cityWithPalette.city;
    palette = cityWithPalette.palette;
    inProgress = true;
    notifyListeners();
  }
}
