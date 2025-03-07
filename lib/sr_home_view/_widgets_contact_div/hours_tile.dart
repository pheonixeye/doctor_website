import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/functions/time_fns.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class HoursTile extends StatelessWidget {
  const HoursTile({
    super.key,
    required this.schedule,
  });
  final List<Schedule> schedule;
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
                        ? '${e.weekday_en} :\n ${modifyTime(e.start_hour, e.start_min, context)} - ${modifyTime(e.end_hour, e.end_min, context)}'
                        : '${e.weekday_ar} :\n ${modifyTime(e.start_hour, e.start_min, context)} - ${modifyTime(e.end_hour, e.end_min, context)}',
                    align: TextAlign.start,
                    style: style,
                  ),
                );
              }).toList());
        },
      ),
      dense: true,
    );
  }
}
