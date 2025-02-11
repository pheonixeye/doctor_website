import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:provider/provider.dart';

String trNumber(int num, BuildContext context) {
  final isEnglish = context.read<PxLocale>().lang == 'en';
  if (isEnglish) {
    return '$num';
  } else {
    return ArabicNumbers().convert(num);
  }
}
