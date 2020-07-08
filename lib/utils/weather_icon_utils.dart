class WeatherIconUtils {
  static const String _imagesFolder = 'assets/images';

  static String iconCodeToPath(String iconCode) {
    String name;
    switch (iconCode) {
      case '01d':
        name = 'clear_sky';
        break;
      case '02d':
        name = 'few_clouds';
        break;
      case '03d':
        name = 'scattered_clouds';
        break;
      case '04d':
        name = 'broken_clouds';
        break;
      case '09d':
        name = 'shower_rain';
        break;
      case '10d':
        name = 'rain';
        break;
      case '11d':
        name = 'thunderstorm';
        break;
      case '13d':
        name = 'snow';
        break;
      case '50d':
        name = 'mist';
        break;
    }
    return name != null ? '$_imagesFolder/$name' : null;
  }
}
