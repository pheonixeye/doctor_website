import 'package:doctor_website_models/doctor_website__models.dart' as models;
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/exports/exports.dart';
import 'package:doctor_website/functions/time_fns.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class HoursTile extends StatelessWidget {
  const HoursTile(
      {super.key,
      required this.schedule,
      required this.hasSpecialSchedule,
      this.ssEn,
      this.ssAr});
  final List<models.Schedule> schedule;
  final bool hasSpecialSchedule;
  final String? ssEn;
  final String? ssAr;
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Styles.ADAPTIVEFONTSIZE(context),
      color: Colors.white,
    );
    return ListTile(
      title: Text(
        context.loc.hours,
        style: Styles.TITLESTEXTSYTYLE(context),
      ),
      subtitle: Consumer<PxLocale>(
        builder: (context, l, c) {
          bool isEnglish = l.lang == 'en';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: schedule.map((e) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: LinkText(
                  isEnglish
                      ? '${e.weekdayEn} :\n ${modifyTime(e.startHour, e.startMinute, context)} - ${modifyTime(e.endHour, e.endMinute, context)}'
                      : '${e.weekdayAr} :\n ${modifyTime(e.startHour, e.startMinute, context)} - ${modifyTime(e.endHour, e.endMinute, context)}',
                  align: TextAlign.start,
                  style: style,
                ),
              );
            }).toList()
              ..add(Padding(
                padding: const EdgeInsets.all(4.0),
                child: LinkText(
                  hasSpecialSchedule
                      ? isEnglish
                          ? ssEn!
                          : ssAr!
                      : '',
                  style: style,
                ),
              )),
          );
        },
      ),
      dense: true,
    );
  }
}
