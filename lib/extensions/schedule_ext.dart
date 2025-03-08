import 'package:doctor_website/functions/time_fns.dart';
import 'package:doctor_website/models/schedule.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ScheduleExt on Schedule {
  bool isEnglish(BuildContext context) => context.read<PxLocale>().lang == 'en';

  String scheduleString(BuildContext context) => isEnglish(context)
      ? 'From ${modifyTime(start_hour, start_min, context)} To ${modifyTime(end_hour, end_min, context)}'
      : 'من ${modifyTime(start_hour, start_min, context)} حتي ${modifyTime(end_hour, end_min, context)}';
  String dayString(BuildContext context) {
    return isEnglish(context) ? weekday_en : weekday_ar;
  }
}
