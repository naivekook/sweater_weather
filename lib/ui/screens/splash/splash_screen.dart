import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/main.dart';
import 'package:sweaterweather/ui/screens/splash/splash_controller.dart';
import 'package:sweaterweather/ui/widgets/weather_icon_loader.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashController(),
      child: _Fork(),
    );
  }
}

class _Fork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
        builder: (BuildContext context, SplashController controller, Widget child) {
      if (controller.readyToGo) {
        return MainApp();
      } else {
        return MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            backgroundColor: const Color(0xFFBCE8F4),
            body: SafeArea(
              child: _SplashContent(),
            ),
          ),
        );
      }
    });
  }
}

class _SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
        builder: (BuildContext context, SplashController controller, Widget child) {
      if (controller.hasError) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _showMaterialDialog(context);
        });
      }
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: WeatherIconLoader(),
      );
    });
  }

  _showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Service unavailable'),
              content:
                  Text('Something went wrong, check you internet connection or try again later.'),
              actions: [
                FlatButton(
                  child: Text('Try again'),
                  onPressed: () {
                    Navigator.pop(context);
                    Provider.of<SplashController>(context, listen: false).refreshWeather();
                  },
                ),
              ],
            ));
  }
}
