import 'package:flutter/widgets.dart';
import 'package:sweaterweather/models/palette.dart';
import 'package:sweaterweather/ui/screens/weather/weather_grid_item.dart';
import 'package:sweaterweather/ui/widgets/single_property_widget.dart';

class WeatherAdditionalProperties extends StatelessWidget {
  final List<WeatherGridItem> _items;
  final Palette _palette;

  WeatherAdditionalProperties(this._items, this._palette);

  @override
  Widget build(BuildContext context) {
    if (_items.isNotEmpty) {
      return Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _listWithDividers(_items.take(3).map((item) => SinglePropertyWidget(
                item.title,
                item.subtitle,
                _palette.secondaryFontColor,
                _palette.primaryFontColor))),
          ),
          SizedBox(width: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _listWithDividers(_items.skip(3).map((item) => SinglePropertyWidget(
                item.title,
                item.subtitle,
                _palette.secondaryFontColor,
                _palette.primaryFontColor))),
          ),
        ],
      );
    } else {
      return Container();
    }
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
