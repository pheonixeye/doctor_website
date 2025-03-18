import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/functions/time_fns.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:provider/provider.dart';

class HoursTile extends StatelessWidget {
  const HoursTile({
    super.key,
    required this.schedule,
    required this.titleStyle,
    required this.subtitleStyle,
  });
  final List<Schedule> schedule;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.loc.hours, style: titleStyle),
      subtitle: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: schedule.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: LinkText(
                    l.isEnglish
                        ? '${e.weekday_en} :\n ${modifyTime(e.start_hour, e.start_min, context)} - ${modifyTime(e.end_hour, e.end_min, context)}'
                        : '${e.weekday_ar} :\n ${modifyTime(e.start_hour, e.start_min, context)} - ${modifyTime(e.end_hour, e.end_min, context)}',
                    align: TextAlign.start,
                    style: subtitleStyle,
                  ),
                );
              }).toList());
        },
      ),
      dense: true,
    );
  }
}
