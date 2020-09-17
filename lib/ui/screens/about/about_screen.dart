import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 20, right: 8, bottom: 8),
              child: _TopBarWidget(),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'The weather data is provided by ',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: const Color(0xFF3D3F4E),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal)),
                ),
                TextSpan(
                  text: 'OpenWeatherMap',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch('https://openweathermap.org/');
                    },
                ),
                TextSpan(
                  text: '.',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: const Color(0xFF3D3F4E),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal)),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: const Color(0xFF7F808C),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'About',
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: const Color(0xFF3D3F4E),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
        )
      ],
    );
  }
}
