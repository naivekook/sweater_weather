import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/app_router.dart';
import 'package:sweaterweather/models/city_with_palette.dart';
import 'package:sweaterweather/ui/screens/weather/weather_controller.dart';
import 'package:sweaterweather/ui/widgets/rainbow_spinner_widget.dart';
import 'package:sweaterweather/ui/widgets/toolbar_with_date_widget.dart';
import 'package:sweaterweather/ui/widgets/weather_additional_properties.dart';
import 'package:sweaterweather/utils/weather_icon_utils.dart';

class WeatherScreen extends StatelessWidget {
  final CityWithPalette _cityWithPalette;

  WeatherScreen(this._cityWithPalette);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherController(_cityWithPalette),
      child: _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherController>(builder: (context, controller, child) {
      return Scaffold(
        backgroundColor: Color(controller.palette.backgroundColor),
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
                  child: ToolbarWithDate(controller.city, controller.palette),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 58, top: 8, right: 34, bottom: 8),
                          child: _WeatherWidget(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 58),
                          child: WeatherAdditionalProperties(
                              controller.weatherAdditionalItems, controller.palette),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 44),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Color(controller.palette.secondaryFontColor)),
                            ),
                            onPressed: () {
                              final args = CityWithPalette(controller.city, controller.palette);
                              Navigator.pushNamed(context, AppRouter.WEATHER_DETAILS,
                                  arguments: args);
                            },
                            child: Text(
                              "More details",
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(controller.palette.primaryFontColor),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherController>(builder: (context, controller, child) {
      if (controller.inProgress) {
        context.showLoaderOverlay();
      } else {
        context.hideLoaderOverlay();
      }
      if (controller.weather == null) {
        return Container();
      } else {
        return Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(WeatherIconUtils.codeToIllustration(controller.weather.icon)),
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
                      controller.weather.temp.toInt().toString(),
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: Color(controller.palette.primaryFontColor),
                              fontSize: 112,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800)),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/donut.svg',
                            width: 40,
                            height: 40,
                            color: Color(controller.palette.primaryFontColor),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              controller.weather.description,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(controller.palette.primaryFontColor),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                          SizedBox(height: 2),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'Feels like ${controller.weather.tempFeelsLike.toInt()}°C',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Color(controller.palette.primaryFontColor),
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
