import 'package:doctor_website/models/align_from_string.dart';
import 'package:doctor_website/models/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class HeroTextPositioned extends StatelessWidget {
  const HeroTextPositioned(this.heroText, {super.key});
  final HeroText heroText;
  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, c) {
        final style =
            Styles.HEROITEMTEXTSTYLE(heroText.font_mobile?.toDouble() ?? 16);

        if (l.lang == 'en') {
          return Align(
            alignment: alignmentFromString(heroText.align ?? ''),
            child: Text(
              heroText.text_en ?? '',
              style: style,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Align(
            alignment: alignmentFromString(heroText.align ?? ''),
            child: Text(
              heroText.text_ar ?? '',
              style: style,
              textAlign: TextAlign.center,
            ),
          );
        }
      },
    );
  }
}
