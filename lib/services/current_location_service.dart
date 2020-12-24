import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:sweaterweather/models/hive/city.dart';

class CurrentLocationService {
  static const _BOX = 'current_city';
  static const _KEY = 'city_key';

  Future<Position> getCurrentLocation() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } on PlatformException {} catch (ex, st) {
      FirebaseCrashlytics.instance.recordError(ex, st);
    }
    return position;
  }

  Future updateCurrentCity(City city) async {
    final box = await Hive.openBox(_BOX);
    box.put(_KEY, city);
  }

  Future<City> getCurrentCity() async {
    final box = await Hive.openBox(_BOX);
    return box.get(_KEY);
  }
}
