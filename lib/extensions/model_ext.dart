import 'package:doctor_website_models/doctor_website__models.dart' as models;
import 'package:flutter/material.dart';
import 'package:doctor_website/functions/time_fns.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:provider/provider.dart';

extension ClinicExt on models.Clinic {
  bool isEnglish(BuildContext context) => context.read<PxLocale>().lang == 'en';
}

extension ScheduleExt on models.Schedule {
  bool isEnglish(BuildContext context) => context.read<PxLocale>().lang == 'en';

  String scheduleString(BuildContext context) => isEnglish(context)
      ? 'From ${modifyTime(startHour, startMinute, context)} To ${modifyTime(endHour, endMinute, context)}'
      : 'من ${modifyTime(startHour, startMinute, context)} حتي ${modifyTime(endHour, endMinute, context)}';
  String dayString(BuildContext context) {
    return isEnglish(context) ? weekdayEn : weekdayAr;
  }
}
