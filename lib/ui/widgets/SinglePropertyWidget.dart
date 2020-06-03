import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SinglePropertyWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  SinglePropertyWidget({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: const Color(0xFF7F808C),
                  fontSize: 10,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal)),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          subtitle,
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: const Color(0xFF3D3F4E),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
        )
      ],
    );
  }
}
