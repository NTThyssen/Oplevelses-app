import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme
ThemeData appTheme = ThemeData(
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  ),
  brightness: Brightness.light,
  splashColor: white,
  accentColor: blue,
  primaryColor: primaryBlue,
  backgroundColor: white,
  dialogBackgroundColor: white,
  dialogTheme: DialogTheme(
    backgroundColor: white,
  ),
  scaffoldBackgroundColor: white,
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  textTheme: GoogleFonts.merriweatherSansTextTheme().copyWith(
    button: GoogleFonts.merriweatherSans().copyWith(
      color: white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),

    /* Title */
    headline1: GoogleFonts.merriweatherSans().copyWith(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),

    /* Subtitle */
    headline2: GoogleFonts.merriweatherSans().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),

    /* Header */
    headline3: GoogleFonts.merriweatherSans().copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),

    /* Body text */
    bodyText1: GoogleFonts.merriweatherSans().copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),

    /* Input field placeholder */
    bodyText2: GoogleFonts.merriweatherSans().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),

    /* Small header */
    headline4: GoogleFonts.merriweatherSans().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),

    /* Small grey header */
    headline5: GoogleFonts.merriweatherSans().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
  ),
);

TextStyle titleTextStyle = appTheme.textTheme.headline1.copyWith(color: white);
TextStyle headerTextStyle = appTheme.textTheme.headline2.copyWith(color: white);
TextStyle smallHeaderTextStyle =
    appTheme.textTheme.headline3.copyWith(color: white);
TextStyle bodyTextStyle = appTheme.textTheme.bodyText1.copyWith(color: white);
TextStyle inputFieldTextStyle =
    appTheme.textTheme.bodyText2.copyWith(color: white);
TextStyle cardTitleTextStyle =
    appTheme.textTheme.headline4.copyWith(color: white);
TextStyle smallGreyHeaderTextStyle =
    appTheme.textTheme.headline5.copyWith(color: lightGrey);

/* 
  Colors from figma:
  https://www.figma.com/file/nELA6ykZqxKFR2n3VSs0LB/VVS?node-id=248%3A1783
*/

/* Blue primary */
const Color primaryBlue = Color(0xff1D2139);
/* White */
const Color white = Color(0xffFFFFFF);
/* Blue */
const Color blue = Color(0xff83C7F2);
/* Light Grey */
const Color lightGrey = Color(0xffC4C4C4);
