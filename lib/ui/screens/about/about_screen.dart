import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _TopBarWidget(),
            ),
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
