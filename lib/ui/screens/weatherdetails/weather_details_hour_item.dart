import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDetailsHourItem extends StatelessWidget {
  final String degreeText;
  final String iconPath;
  final String timeText;
  final int primaryColor;
  final int secondaryColor;

  WeatherDetailsHourItem(
      this.degreeText, this.iconPath, this.timeText, this.primaryColor, this.secondaryColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          degreeText,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: Color(primaryColor),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
        ),
        Container(
          alignment: Alignment.center,
          child: Image.asset(iconPath, color: Color(primaryColor)),
        ),
        Text(
          timeText,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: Color(secondaryColor),
                  fontSize: 9,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal)),
        )
      ],
    );
  }
}
