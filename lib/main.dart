import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweaterweather/router.dart';

Future<void> main() async {
  await DotEnv().load('.env');
//  final weatherClient = WeatherService(DotEnv().env['WEATHER_API_KEY']);
//  final result =
//      await weatherClient.getWeatherByLocation(Location(lat: 34.0201598, lon: -118.6926001));
//  if (result.isSuccess()) {
//    print("result" + result.successValue.toString());
//  } else {
//    print("result" + result.errorValue);
//  }

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      onGenerateRoute: Router.generateRoute,
      initialRoute: Router.HOME,
    );
  }
}
