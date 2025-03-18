// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:doctor_website/models/site_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_website/functions/res_size.dart';

class Styles {
  final SiteSettings? settings;

  const Styles._(this.settings);

  static Styles _internal(SiteSettings? settings) => Styles._(settings);

  factory Styles(SiteSettings? settings) {
    return _internal(settings);
  }

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

  ThemeData LIGHTTHEMEDATA(BuildContext context) => ThemeData(
        primaryColor: Styles.COLOR,
        // fontFamily: 'Cairo',
        useMaterial3: true,
        scaffoldBackgroundColor: SCAFFOLDCOLOR.shade100,
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Color(
                int.parse('0xff${settings?.button_font_color ?? 'ffffff'}'))),
            backgroundColor: WidgetStatePropertyAll(
                Color(int.parse('0xff${settings?.button_color ?? 'ffffff'}'))),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Color(
                int.parse('0xff${settings?.button_font_color ?? 'ffffff'}'))),
            backgroundColor: WidgetStatePropertyAll(
                Color(int.parse('0xff${settings?.button_color ?? 'ffffff'}'))),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Color(
              int.parse('0xff${settings?.button_font_color ?? 'ffffff'}')),
          backgroundColor:
              Color(int.parse('0xff${settings?.button_color ?? 'ffffff'}')),
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

  static final MAINPAGECOMPONENTCARDCOLOR = Colors.white.withOpacity(0.0);

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

  TextStyle WEBSITETITLETEXTSYTYLE(BuildContext context) => TextStyle(
        fontSize: isMobile(context)
            ? (settings?.website_title_font_size_mobile)?.toDouble() ?? 16
            : (settings?.website_title_font_size_other)?.toDouble() ?? 16,
        color: Color(
            int.parse('0xff${settings?.website_title_font_color ?? 'ffffff'}')),
        shadows: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 2,
            color: Color(int.parse(
                '0xff${settings?.website_title_font_shadow_color ?? 'ffffff'}')),
          ),
        ],
      );

  TextStyle TITLESTEXTSYTYLE(BuildContext context) => TextStyle(
        fontSize: isMobile(context)
            ? (settings?.titles_font_size_mobile)?.toDouble() ?? 16
            : (settings?.titles_font_size_other)?.toDouble() ?? 16,
        color:
            Color(int.parse('0xff${settings?.titles_font_color ?? 'ffffff'}')),
        shadows: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 2,
            color: Color(int.parse(
                '0xff${settings?.titles_font_shadow_color ?? 'ffffff'}')),
          ),
        ],
      );

  TextStyle SUBTITLESTEXTSYTYLE(BuildContext context) => TextStyle(
        fontSize: isMobile(context)
            ? (settings?.subtitles_font_size_mobile)?.toDouble() ?? 16
            : (settings?.subtitles_font_size_other)?.toDouble() ?? 16,
        color: Color(
            int.parse('0xff${settings?.subtitles_font_color ?? 'ffffff'}')),
        shadows: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 2,
            color: Color(int.parse(
                '0xff${settings?.subtitles_font_shadow_color ?? 'ffffff'}')),
          ),
        ],
      );

  TextStyle TEXTTEXTSYTYLE(BuildContext context) => TextStyle(
        fontSize: isMobile(context)
            ? (settings?.text_font_size_mobile)?.toDouble() ?? 16
            : (settings?.text_font_size_other)?.toDouble() ?? 16,
        color: Color(int.parse('0xff${settings?.text_font_color ?? 'ffffff'}')),
        shadows: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 2,
            color: Color(int.parse(
                '0xff${settings?.text_font_shadow_color ?? 'ffffff'}')),
          ),
        ],
      );
  TextStyle HEROTITLESTEXTSYTYLE(
    BuildContext context,
    num? m_font_size,
    num? o_font_size,
  ) =>
      TextStyle(
        fontSize: isMobile(context)
            ? (m_font_size)?.toDouble() ?? 16
            : (o_font_size)?.toDouble() ?? 16,
        color:
            Color(int.parse('0xff${settings?.titles_font_color ?? 'ffffff'}')),
        shadows: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 2,
            color: Color(int.parse(
                '0xff${settings?.titles_font_shadow_color ?? 'ffffff'}')),
          ),
        ],
      );

  TextStyle HEROSUBTITLESTEXTSYTYLE(
    BuildContext context,
    num? m_font_size,
    num? o_font_size,
  ) =>
      TextStyle(
        fontSize: isMobile(context)
            ? (m_font_size)?.toDouble() ?? 16
            : (o_font_size)?.toDouble() ?? 16,
        color: Color(
            int.parse('0xff${settings?.subtitles_font_color ?? 'ffffff'}')),
        shadows: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 2,
            color: Color(int.parse(
                '0xff${settings?.subtitles_font_shadow_color ?? 'ffffff'}')),
          ),
        ],
      );

  TextStyle HEROTEXTTEXTSYTYLE(
    BuildContext context,
    num? m_font_size,
    num? o_font_size,
  ) =>
      TextStyle(
        fontSize: isMobile(context)
            ? (m_font_size)?.toDouble() ?? 16
            : (o_font_size)?.toDouble() ?? 16,
        color: Color(int.parse('0xff${settings?.text_font_color ?? 'ffffff'}')),
        shadows: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 2,
            color: Color(int.parse(
                '0xff${settings?.text_font_shadow_color ?? 'ffffff'}')),
          ),
        ],
      );
}
