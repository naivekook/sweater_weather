import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_item.dart';

class AddCityListTile extends StatelessWidget {
  final CityListItem item;
  final Function(CityListItem) onTap;

  AddCityListTile(this.item, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Image.asset(item.icon, width: 24, height: 24),
                SizedBox(width: 8),
                Text(
                  '${item.city.name}, ',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: const Color(0xFF3D3F4E),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800)),
                ),
                Text(
                  item.city.countryName,
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: const Color(0xFF3D3F4E),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              '${item.temp}°C, ${item.weather}',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: const Color(0xFF7F808C),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400)),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: _createButton(item.added),
        ),
      ],
    );
  }

  Widget _createButton(bool added) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Text(
            added ? 'Added' : 'Add',
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: added ? const Color(0xFF24B021) : const Color(0xFF3D3F4E),
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal)),
          ),
          Visibility(
            visible: item.added,
            child: Icon(
              Icons.check,
              color: const Color(0xFF24B021),
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: added ? const Color(0x6624B021) : const Color(0x4D7F808C),
            width: 1,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () => onTap(item),
    );
  }
}
