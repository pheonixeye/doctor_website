import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:provider/provider.dart';

String modifyTime(int hour, int minute, BuildContext context) {
  final bool isEnglish = context.read<PxLocale>().lang == 'en';
  int hourI = hourInt(hour);
  String hourS = isEnglish ? '$hourI' : ArabicNumbers().convert('$hourI');
  String minuteS = isEnglish ? '$minute' : ArabicNumbers().convert('$minute');

  return isEnglish
      ? '$hourS : $minuteS ${ampm(hour, isEnglish)}'
      : '$minuteS : $hourS ${ampm(hour, isEnglish)}';
}

String ampm(int hour, bool isEnglish) {
  final String am = isEnglish ? 'A.M.' : 'صباحا';
  final String pm = isEnglish ? 'P.M.' : 'مسائا';
  if (hour < 12) {
    return am;
  } else if (hour > 12) {
    return pm;
  } else {
    return pm;
  }
}

int hourInt(int hour) {
  if (hour < 12) {
    return hour;
  } else if (hour > 12) {
    return hour - 12;
  } else {
    return hour;
  }
}

DateTime NOW = DateTime(
  DateTime.now().year,
  DateTime.now().month,
  DateTime.now().day,
);

extension StringToDate on String {
  String toFormattedDate(BuildContext context) {
    late final DateTime d;
    try {
      d = DateTime.parse(this);
    } catch (e) {
      return 'Unable To Parse Supplied Date Format.';
    }
    bool isEnglish = context.read<PxLocale>().lang == 'en';
    if (isEnglish) {
      return '${d.day}-${d.month}-${d.year} ${hourInt(d.hour)}:${d.minute} ${ampm(d.hour, isEnglish)}';
    } else {
      return '${ArabicNumbers().convert(d.day)}-${ArabicNumbers().convert(d.month)}-${ArabicNumbers().convert(d.year)} ${ArabicNumbers().convert(d.minute)}:${ArabicNumbers().convert(hourInt(d.hour))} ${ampm(d.hour, isEnglish)}';
    }
  }
}
