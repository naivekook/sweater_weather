import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDetailsDayItem extends StatelessWidget {
  final String dayText;
  final String iconPath;
  final String dayTemp;
  final String nightTemp;
  final int textColor;

  WeatherDetailsDayItem(this.dayText, this.iconPath, this.dayTemp, this.nightTemp, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dayText,
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: Color(textColor),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Image.asset(iconPath, color: Color(textColor)),
        ),
        SizedBox(width: 24),
        Text(
          dayTemp,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: Color(textColor),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
        ),
        SizedBox(width: 24),
        Text(
          nightTemp,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: Color(textColor),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}
