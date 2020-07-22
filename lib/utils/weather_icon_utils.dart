class WeatherIconUtils {
  static const String _imagesFolder = 'assets/images';
  static const String _illustrationsFolder = 'assets/illustrations';

  static String codeToImage(String iconCode) {
    String name;
    switch (iconCode.substring(0, 2)) {
      case '01':
        name = 'clear_sky';
        break;
      case '02':
        name = 'few_clouds';
        break;
      case '03':
        name = 'scattered_clouds';
        break;
      case '04':
        name = 'broken_clouds';
        break;
      case '09':
        name = 'shower_rain';
        break;
      case '10':
        name = 'rain';
        break;
      case '11':
        name = 'thunderstorm';
        break;
      case '13':
        name = 'snow';
        break;
      case '50':
        name = 'mist';
        break;
    }
    return name != null ? '$_imagesFolder/$name.svg' : null;
  }

  static String codeToIllustration(String iconCode) {
    String name;
    switch (iconCode.substring(0, 2)) {
      case '01':
        name = 'clear_sky_day';
        break;
      case '02':
        name = 'few_clouds_day';
        break;
      case '03':
        name = 'scattered_clouds_day';
        break;
      case '04':
        name = 'broken_clouds_day';
        break;
      case '09':
        name = 'shower_rain_day';
        break;
      case '10':
        name = 'rain_day';
        break;
      case '11':
        name = 'thunderstorm_day';
        break;
      case '13':
        name = 'snow_day';
        break;
      case '50':
        name = 'mist_day';
        break;
    }
    return name != null ? '$_illustrationsFolder/$name.png' : null;
  }
}
