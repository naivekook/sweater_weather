import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          height: 38,
          width: 38,
          child: SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            fit: BoxFit.scaleDown,
          ),
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
