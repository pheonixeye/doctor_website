import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/models/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class HeroTextUnpositioned extends StatelessWidget {
  const HeroTextUnpositioned({super.key, required this.heroTextList});
  final List<HeroText> heroTextList;
  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, c) {
        return Column(
          children: heroTextList.map((e) {
            final style =
                Styles.HEROITEMTEXTSTYLE(e.font_mobile?.toDouble() ?? 16);

            if (l.isEnglish) {
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  top: (isMobile(context)
                      ? e.top_mobile ?? 0
                      : e.top_other ?? 0) as double,
                  start: (isMobile(context)
                      ? e.start_mobile ?? 0
                      : e.start_other ?? 0) as double,
                ),
                child: Text(
                  e.text_en ?? '',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  top: (isMobile(context)
                      ? e.top_mobile ?? 0
                      : e.top_other ?? 0) as double,
                  start: (isMobile(context)
                      ? e.start_mobile ?? 0
                      : e.start_other ?? 0) as double,
                ),
                child: Text(
                  e.text_ar ?? '',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              );
            }
          }).toList(),
        );
      },
    );
  }
}
