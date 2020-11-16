import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDetailsHourItem extends StatelessWidget {
  final String degreeText;
  final String iconPath;
  final String timeText;
  final int degreeTextColor;
  final int timeTextColor;

  WeatherDetailsHourItem(
      this.degreeText, this.iconPath, this.timeText, this.degreeTextColor, this.timeTextColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          degreeText,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: Color(degreeTextColor),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
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
        Text(
          timeText,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: Color(timeTextColor),
                  fontSize: 9,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal)),
        )
      ],
    );
  }
}
