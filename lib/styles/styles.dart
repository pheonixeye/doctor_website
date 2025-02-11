// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_website/functions/res_size.dart';

class Styles {
  static const COLOR = Colors.blue;

  static const SCAFFOLDCOLOR = Colors.grey;

  static const double MOBILEFONTSIZE = 10;

  static const double OTHERFONTSIZE = 20;

  static double ADAPTIVEFONTSIZE(BuildContext context) {
    return isMobile(context) ? MOBILEFONTSIZE : OTHERFONTSIZE;
  }

  static const HEROCARDBORDER = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );
  static const ABOUTCARDBORDER = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
  );

  static final CARDSHAPE = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.circular(20),
  );

  static ThemeData LIGHTTHEMEDATA(BuildContext context) => ThemeData(
        primarySwatch: Styles.COLOR,
        // fontFamily: 'Cairo',
        useMaterial3: true,
        scaffoldBackgroundColor: SCAFFOLDCOLOR.shade100,
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          unselectedLabelStyle: GoogleFonts.cairo(
            fontSize: 12,
          ),
        ),
      );

  static TextStyle TITLESTEXTSYTYLE(BuildContext context) => TextStyle(
        fontSize: isMobile(context) ? 16 : 26,
        color: Colors.white,
        decorationColor: Colors.amber,
        decorationStyle: TextDecorationStyle.wavy,
        shadows: const [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.amber,
          ),
        ],
      );
  static TextStyle ARTICLETITLESTEXTSYTYLE(BuildContext context) => TextStyle(
        fontSize: isMobile(context) ? 18 : 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        decorationColor: Colors.amber,
        decorationStyle: TextDecorationStyle.wavy,
        shadows: const [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.amber,
          ),
        ],
      );
  static TextStyle ARTICLESUBTITLESTEXTSYTYLE(BuildContext context) =>
      TextStyle(
        fontSize: isMobile(context) ? 14 : 24,
        color: Colors.white,
        decorationColor: Colors.blue,
        decorationStyle: TextDecorationStyle.wavy,
        shadows: const [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.blue,
          ),
        ],
      );

  static TextStyle SUBTITLESTEXTSYTYLE(BuildContext context) => TextStyle(
        fontSize: isMobile(context) ? 12 : 22,
        color: Colors.white,
        decorationColor: Colors.amber,
        decorationStyle: TextDecorationStyle.wavy,
        shadows: const [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.amber,
          ),
        ],
      );

  static TextStyle CLINICSTEXTSYTYLE(BuildContext context) => TextStyle(
        fontSize: isMobile(context) ? 16 : 26,
        color: Colors.white,
        decorationColor: Colors.blue,
        decorationStyle: TextDecorationStyle.wavy,
        shadows: const [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.amber,
          ),
        ],
      );

  static TextStyle TAGSTEXTSYTYLE() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        decorationColor: Colors.blue,
        decorationStyle: TextDecorationStyle.wavy,
        shadows: [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.blue,
          ),
        ],
      );

  static final MAINPAGECOMPONENTCARDCOLOR = Colors.white.withOpacity(0.0);

  static TextStyle HEROITEMTEXTSTYLE(double fontSize) => TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        decorationColor: Colors.amber,
        decorationStyle: TextDecorationStyle.double,
        shadows: const [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.amber,
          ),
        ],
      );

  static final CONTAINERDECORATION = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white.withOpacity(0.8),
    boxShadow: [
      BoxShadow(
        offset: const Offset(3, 3),
        blurRadius: 3,
        spreadRadius: 3,
        color: Colors.blue.shade200,
      ),
    ],
  );
}
