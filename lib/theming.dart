import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Theming {
  static ThemeData theme() => ThemeData(
      primarySwatch: Colors.brown,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline1: GoogleFonts.openSans(
            fontSize: 94,
            fontWeight: FontWeight.w300,
            letterSpacing: -1.5
        ),
        headline2: GoogleFonts.openSans(
            fontSize: 59,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5
        ),
        headline3: GoogleFonts.openSans(
            fontSize: 47,
            fontWeight: FontWeight.w400
        ),
        headline4: GoogleFonts.openSans(
            fontSize: 33,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25
        ),
        headline5: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w400
        ),
        headline6: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15
        ),
        subtitle1: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15
        ),
        subtitle2: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1
        ),
        bodyText2: GoogleFonts.lato(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5
        ),
        bodyText1: GoogleFonts.lato(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25
        ),
        button: GoogleFonts.lato(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25
        ),
        caption: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4
        ),
        overline: GoogleFonts.lato(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5
        ),
      )
  );
}