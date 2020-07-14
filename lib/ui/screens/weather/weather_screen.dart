import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/ui/screens/weather/weather_controller.dart';
import 'package:sweaterweather/ui/widgets/single_property_widget.dart';

class WeatherScreen extends StatelessWidget {
  final City city;

  WeatherScreen(this.city);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherController(city),
      child: Scaffold(
        backgroundColor: const Color(0xFFDDEEF3),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: _TopBarWidget(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 58),
                child: _WeatherWidget(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 58),
                child: _WeatherAdditionalProperties(),
              ),
              OutlineButton(
                child: Text(
                  'More details',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: const Color(0xFF3D3F4E),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800)),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final info = Provider.of<WeatherController>(context, listen: false).getHeaderInfo();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: const Color(0xFF7F808C),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              info.title,
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: const Color(0xFF3D3F4E),
                      fontSize: 36,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800)),
            ),
            SizedBox(height: 8),
            Text(
              info.date,
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: const Color(0xFF7F808C),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal)),
            ),
            SizedBox(height: 6),
            Text(
              info.dayOfWeek,
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: const Color(0xFF7F808C),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal)),
            ),
          ],
        )
      ],
    );
  }
}

class _WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topRight,
          child: Image(image: AssetImage('assets/illustrations/few_clouds_day.png')),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Text(
                  '12',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: const Color(0xFF3D3F4E),
                          fontSize: 112,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'o',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: const Color(0xFF3D3F4E),
                              fontSize: 44,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800)),
                    ),
                    Text(
                      'Mostly cloudy',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: const Color(0xFF3D3F4E),
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal)),
                    ),
                    Text(
                      'Feels like 11°C',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: const Color(0xFF3D3F4E),
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
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
                children: _listWithDividers(items.take(3).map(
                    (item) => SinglePropertyWidget(title: item.title, subtitle: item.subtitle)))),
            SizedBox(width: 50),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _listWithDividers(items.skip(3).map(
                    (item) => SinglePropertyWidget(title: item.title, subtitle: item.subtitle)))),
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
