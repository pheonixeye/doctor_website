import 'package:doctor_website_models/doctor_website__models.dart';
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
        final style = Styles.HEROITEMTEXTSTYLE(heroText.fontSize);

        if (l.lang == 'en') {
          return Positioned(
            top: heroText.yPos,
            left: heroText.xPos,
            child: Text(
              heroText.textEn,
              style: style,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Positioned(
            top: heroText.yPos,
            right: heroText.xPos,
            child: Text(
              heroText.textAr,
              style: style,
              textAlign: TextAlign.center,
            ),
          );
        }
      },
    );
  }
}
