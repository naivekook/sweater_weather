import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sweaterweather/app_router.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/ui/widgets/weather_icon_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

  runZoned(() {
    runApp(SplashApp());
  }, onError: FirebaseCrashlytics.instance.recordError);
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.HOME,
    );
  }
}

class SplashApp extends StatelessWidget {
  final _starter = AppStarter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _starter.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MainApp();
        } else {
          return MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              backgroundColor: const Color(0xFFBCE8F4),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: WeatherIconLoader(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
