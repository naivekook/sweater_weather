import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/models/city_with_palette.dart';
import 'package:sweaterweather/ui/screens/weatherdetails/weather_details_controller.dart';
import 'package:sweaterweather/ui/screens/weatherdetails/weather_details_day_item.dart';
import 'package:sweaterweather/ui/screens/weatherdetails/weather_details_hour_item.dart';
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

List<WeatherDetailsHourItem> itemList = [
  WeatherDetailsHourItem('11•', "assets/images/broken_clouds.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/few_clouds.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/rain.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/mist.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/snow.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/clear_sky.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/mist.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/mist.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/mist.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/mist.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
  WeatherDetailsHourItem('11•', "assets/images/mist.svg", '12:00', 0xFF3D3F4E, 0xFF7F808C),
];

List<WeatherDetailsDayItem> itemList2 = [
  WeatherDetailsDayItem('Thursday, 14', "assets/images/broken_clouds.svg", '11', '5', 0xFF3D3F4E),
  WeatherDetailsDayItem('Thursday, 14', "assets/images/few_clouds.svg", '11', '5', 0xFF3D3F4E),
  WeatherDetailsDayItem('Saturday, 16', "assets/images/rain.svg", '11', '5', 0xFF3D3F4E),
  WeatherDetailsDayItem('Sunday, 17', "assets/images/mist.svg", '11', '5', 0xFF3D3F4E),
  WeatherDetailsDayItem('Monday, 18', "assets/images/snow.svg", '11', '5', 0xFF3D3F4E),
  WeatherDetailsDayItem('Tuesday, 19', "assets/images/clear_sky.svg", '11', '5', 0xFF3D3F4E),
];

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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 40),
                          child: _HourList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 36, right: 40),
                          child: _DayList(),
                        ),
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

class _HourList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 22),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (context, index) => itemList[index]
        ),
      ),
    );
  }
}

class _DayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: itemList2,
    );
  }
}
