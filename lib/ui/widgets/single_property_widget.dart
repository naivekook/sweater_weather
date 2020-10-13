import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SinglePropertyWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final int titleColor;
  final int subtitleColor;

  SinglePropertyWidget(this.title, this.subtitle, this.titleColor, this.subtitleColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: Color(titleColor),
                  fontSize: 10,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal)),
        ),
        SizedBox(height: 12),
        Text(
          subtitle,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: Color(subtitleColor),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
        )
      ],
    );
  }
}
