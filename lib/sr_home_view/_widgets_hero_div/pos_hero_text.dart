import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/models/align_from_string.dart';
import 'package:doctor_website/models/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:provider/provider.dart';

class HeroTextPositioned extends StatelessWidget {
  const HeroTextPositioned(this.heroText, {super.key, required this.style});
  final HeroText heroText;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, _) {
        return Align(
          alignment: alignmentFromString(heroText.align ?? ''),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: (isMobile(context)
                  ? heroText.top_mobile ?? 0
                  : heroText.top_other ?? 0) as double,
              start: (isMobile(context)
                  ? heroText.start_mobile ?? 0
                  : heroText.start_other ?? 0) as double,
            ),
            child: Text(
              l.isEnglish ? heroText.text_en ?? '' : heroText.text_ar ?? '',
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
