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
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    button: GoogleFonts.lato().copyWith(
      color: white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),

    /* Title */
    headline1: GoogleFonts.lato().copyWith(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),

    /* Subtitle */
    headline2: GoogleFonts.lato().copyWith(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),

    /* Header */
    headline3: GoogleFonts.lato().copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),

    /* Body text */
    bodyText1: GoogleFonts.lato().copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 1.5,
    ),

    /* Input field placeholder */
    bodyText2: GoogleFonts.lato().copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),

    /* Card title */
    headline4: GoogleFonts.lato().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),

    /* Small header */
    headline5: GoogleFonts.lato().copyWith(
      fontSize: 17,
      letterSpacing: 0.7,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),

    /* Small grey header */
    headline6: GoogleFonts.lato().copyWith(
      fontSize: 17,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
  ),
);

TextStyle titleTextStyle = appTheme.textTheme.headline1.copyWith(color: white);
TextStyle subtitleTextStyle =
    appTheme.textTheme.headline2.copyWith(color: white);
TextStyle headerTextStyle = appTheme.textTheme.headline3.copyWith(color: white);
TextStyle bodyTextStyle = appTheme.textTheme.bodyText1.copyWith(color: white);
TextStyle inputFieldTextStyle =
    appTheme.textTheme.bodyText2.copyWith(color: lightGrey);
TextStyle cardTitleTextStyle =
    appTheme.textTheme.headline4.copyWith(color: Colors.black);
TextStyle smallHeaderTextStyle =
    appTheme.textTheme.headline5.copyWith(color: white);
TextStyle smallGreyHeaderTextStyle =
    appTheme.textTheme.headline6.copyWith(color: white);

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
