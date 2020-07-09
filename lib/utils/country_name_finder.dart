import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class CountryNameFinder {
  List<_Country> parsedCountries;

  Future<String> find(String code) async {
    if (parsedCountries == null) {
      final json = await rootBundle.loadString('assets/country_codes.json');
      parsedCountries = _parseJson(json);
    }
    return parsedCountries
        .firstWhere((e) => e.code.toLowerCase() == code.toLowerCase())
        .name;
  }

  List<_Country> _parseJson(String jsonString) {
    if (jsonString == null) return null;

    final Iterable parsed = jsonDecode(jsonString);
    return parsed
        .map((e) => _Country.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class _Country {
  final String name;
  final String code;

  _Country(this.name, this.code);

  factory _Country.fromJson(Map<String, dynamic> json) {
    return new _Country(
      json['Name'] as String,
      json['Code'] as String,
    );
  }
}
