import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sweaterweather/app_starter.dart';
import 'package:sweaterweather/router.dart';

void main() {
  Crashlytics.instance.enableInDevMode = !kReleaseMode;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

  runZoned(() {
    runApp(SplashApp());
  }, onError: Crashlytics.instance.recordError);
}

class MainApp extends StatelessWidget {
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
            home: Scaffold(backgroundColor: Colors.white),
          );
        }
      },
    );
  }
}
