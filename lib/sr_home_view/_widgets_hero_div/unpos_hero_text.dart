import 'package:doctor_website_models/doctor_website__models.dart';
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
            final style = Styles.HEROITEMTEXTSTYLE(e.fontSize);

            if (l.lang == 'en') {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  e.textEn,
                  style: style,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  e.textAr,
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
