import 'package:sweaterweather/models/palette.dart';
import 'package:sweaterweather/models/weather.dart';

class DayNightPalette {
  final DayPalette _dayPalette = DayPalette();
  final NightPalette _nightPalette = NightPalette();

  Palette getPalette(Weather weather) {
    if (weather == null) return _dayPalette;

    if (isDay(weather)) {
      return _dayPalette;
    } else {
      return _nightPalette;
    }
  }

  bool isDay(Weather weather) {
    if (weather != null && weather.icon.contains('d')) {
      return true;
    } else {
      return false;
    }
  }

  bool isNight(Weather weather) {
    return !isDay(weather);
  }
}

class DayPalette implements Palette {
  @override
  int backgroundColor = 0xFFDDEEF3;

  @override
  int primaryFontColor = 0xFF3D3F4E;

  @override
  int secondaryFontColor = 0xFF7F808C;
}

class NightPalette implements Palette {
  @override
  int backgroundColor = 0xFF283143;

  @override
  int primaryFontColor = 0xFFDDEEF3;

  @override
  int secondaryFontColor = 0xFF7F808C;
}
