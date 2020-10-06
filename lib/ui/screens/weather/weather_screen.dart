import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/ui/screens/weather/weather_controller.dart';
import 'package:sweaterweather/ui/widgets/rainbow_spinner_widget.dart';
import 'package:sweaterweather/ui/widgets/single_property_widget.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class WeatherScreen extends StatelessWidget {
  final City city;

  WeatherScreen(this.city);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherController(city),
      child: Scaffold(
        backgroundColor: const Color(0xFFDDEEF3),
        body: LoaderOverlay(
          overlayWidget: Center(
            child: RainbowSpinnerWidget(),
          ),
          overlayColor: Colors.white,
          overlayOpacity: 0.9,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 20, bottom: 8, right: 34),
                  child: _TopBarWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 58, top: 8, right: 34, bottom: 8),
                  child: _WeatherWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 58),
                  child: _WeatherAdditionalProperties(),
                ),
              ],
            ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Expanded(
              child: Text(
                info.title,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: const Color(0xFF3D3F4E),
                        fontSize: 32,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            info.date,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: const Color(0xFF7F808C),
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, left: 50),
          child: Text(
            info.dayOfWeek,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: const Color(0xFF7F808C),
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal)),
          ),
        ),
      ],
    );
  }
}

class _WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherController>(builder: (context, value, child) {
      if (value.inProgress) {
        context.showLoaderOverlay();
      } else {
        context.hideLoaderOverlay();
      }
      if (value.weather == null) {
        return Container();
      } else {
        return Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(WeatherIconUtils.codeToIllustration(value.weather.icon)),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value.weather.temp.toInt().toString(),
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: const Color(0xFF3D3F4E),
                              fontSize: 112,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800)),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset('assets/images/donut.svg', width: 40, height: 40),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              value.weather.description,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: const Color(0xFF3D3F4E),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                          SizedBox(height: 2),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'Feels like ${value.weather.tempFeelsLike.toInt()}°C',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: const Color(0xFF3D3F4E),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    });
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
