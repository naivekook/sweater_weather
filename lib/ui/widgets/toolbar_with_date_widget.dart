import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sweaterweather/models/hive/city.dart';
import 'package:sweaterweather/models/palette.dart';

// ignore: must_be_immutable
class ToolbarWithDate extends StatelessWidget {
  String title;
  String date;
  String dayOfWeek;
  int primaryFontColor;
  int secondaryFontColor;

  ToolbarWithDate(City city, Palette palette) {
    title = city.name;
    DateTime dateTime = DateTime.now();
    date = '${DateFormat('MMMM').format(dateTime)}, ${DateFormat('d').format(dateTime)}';
    dayOfWeek = DateFormat.EEEE().format(dateTime);
    primaryFontColor = palette.primaryColor;
    secondaryFontColor = palette.secondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Color(primaryFontColor),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 2),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: Color(primaryFontColor),
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
            date,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: Color(secondaryFontColor),
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, left: 50),
          child: Text(
            dayOfWeek,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: Color(secondaryFontColor),
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal)),
          ),
        ),
      ],
    );
  }
}
