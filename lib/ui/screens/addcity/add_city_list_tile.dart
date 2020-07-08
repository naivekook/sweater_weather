import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweaterweather/models/city.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_item.dart';

class AddCityListTile extends StatelessWidget {
  final CityListItem item;
  final Function(City) onTap;

  AddCityListTile(this.item, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SvgPicture.asset(item.icon, width: 16, height: 16),
                  ),
                ),
                TextSpan(
                  text: '${item.city.name},',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: const Color(0xFF3D3F4E),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800)),
                ),
                TextSpan(
                  text: item.city.country,
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: const Color(0xFF3D3F4E),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal)),
                ),
              ]),
            ),
            SizedBox(height: 4),
            Text(
              '${item.temp}°C, ${item.weather}',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: const Color(0xFF7F808C),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal)),
            )
          ],
        ),
        _createButton(item.added),
      ],
    );
  }

  Widget _createButton(bool added) {
    return FlatButton(
      child: Text(
        added ? 'Added' : 'Add',
        style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: added ? const Color(0xFF24B021) : const Color(0xFF3D3F4E),
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal)),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: added ? const Color(0xFF24B021) : const Color(0xFF3D3F4E),
            width: 1,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () => onTap(item.city),
    );
  }
}
