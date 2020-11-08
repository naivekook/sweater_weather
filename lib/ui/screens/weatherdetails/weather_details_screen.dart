import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/models/city_with_palette.dart';
import 'package:sweaterweather/ui/screens/weatherdetails/weather_details_controller.dart';
import 'package:sweaterweather/ui/widgets/rainbow_spinner_widget.dart';
import 'package:sweaterweather/ui/widgets/toolbar_with_date_widget.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final CityWithPalette _cityWithPalette;

  WeatherDetailsScreen(this._cityWithPalette);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherDetailsController(_cityWithPalette),
      child: _Screen(),
    );
  }
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherDetailsController>(builder: (context, controller, child) {
      return Scaffold(
        backgroundColor: Color(controller.palette.backgroundColor),
        body: LoaderOverlay(
          overlayWidget: Center(
            child: RainbowSpinnerWidget(),
          ),
          overlayColor: Colors.white,
          overlayOpacity: 0.9,
          child: SafeArea(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 20, bottom: 8, right: 34),
                child: ToolbarWithDate(controller.city, controller.palette),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(),
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
