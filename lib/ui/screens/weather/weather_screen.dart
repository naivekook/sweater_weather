import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/ui/screens/weather/weather_controller.dart';
import 'package:sweaterweather/ui/widgets/SinglePropertyWidget.dart';

class WeatherScreen extends StatelessWidget {
  final City city;

  WeatherScreen(this.city);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDEEF3),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => WeatherController(city),
          child: Container(
            child: _WeatherAdditionalProperties(),
          ),
        ),
      ),
    );
  }
}

class _WeatherAdditionalProperties extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherController>(builder: (context, value, child) {
      final items = value.getGridItems();
      if (items.isNotEmpty) {
        return Row(
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _listWithDividers(
                    items.take(3).map((item) => SinglePropertyWidget(title: item.title, subtitle: item.subtitle)))),
            SizedBox(width: 50),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _listWithDividers(
                    items.skip(3).map((item) => SinglePropertyWidget(title: item.title, subtitle: item.subtitle)))),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  List<Widget> _listWithDividers(Iterable<Widget> list) {
    List<Widget> result = [];
    for (var i = 0; i < list.length; i++) {
      if (i == 0) {
        result.add(list.elementAt(i));
      } else {
        result.add(const SizedBox(height: 30));
        result.add(list.elementAt(i));
      }
    }
    return result;
  }
}
