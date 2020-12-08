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
import 'package:sweaterweather/ui/widgets/weather_additional_properties.dart';

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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 20, bottom: 8, right: 34),
                  child: ToolbarWithDate(controller.city, controller.palette),
                ),
                Expanded(
                  child: _ScrollableContainer(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _ScrollableContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherDetailsController>(builder: (context, controller, child) {
      if (controller.inProgress) {
        context.showLoaderOverlay();
      } else {
        context.hideLoaderOverlay();
      }
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 58, top: 40),
                child: _HourList(controller.weatherHourItems),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 58, top: 36, right: 34),
                child: _DayList(controller.weatherDayItems),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 58, top: 36, right: 34, bottom: 40),
                child: WeatherAdditionalProperties(
                    controller.weatherAdditionalItems, controller.palette),
              ),
            ]),
      );
    });
  }
}

class _HourList extends StatelessWidget {
  final List<WeatherDetailsHourItem> _items;

  _HourList(this._items);

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
          itemCount: _items.length,
          itemBuilder: (context, index) => _items[index],
        ),
      ),
    );
  }
}

class _DayList extends StatelessWidget {
  final List<WeatherDetailsDayItem> _items;

  _DayList(this._items);

  @override
  Widget build(BuildContext context) {
    return Column(children: _items);
  }
}
