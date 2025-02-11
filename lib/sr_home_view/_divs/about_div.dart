import 'package:flutter/material.dart';
import 'package:doctor_website/config/const.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:doctor_website/exports/exports.dart';
import 'package:provider/provider.dart';

const mFont = TextStyle(
  fontSize: 14,
  color: Colors.amber,
);
const oFont = TextStyle(
  fontSize: 22,
  color: Colors.amber,
);

TextStyle _tStyle(BuildContext context) {
  return isMobile(context) ? mFont : oFont;
}

class DivAbout extends StatelessWidget {
  const DivAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageViewAboutDiv(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.ABOUTCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: isMobile(context) ? 1 : 3,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      context.loc.about,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: isMobile(context) ? 22 : 38,
                        color: Colors.white,
                        decorationColor: Colors.amber,
                        decorationStyle: TextDecorationStyle.wavy,
                        shadows: const [
                          BoxShadow(
                            offset: Offset(3, 3),
                            blurRadius: 3,
                            spreadRadius: 3,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //todo: COPYWRITE
                  Consumer<PxLocale>(
                    builder: (context, l, _) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l.isEnglish
                              ? DoctorStaticData.current().aboutEn
                              : DoctorStaticData.current().aboutAr,
                          style: _tStyle(context),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: isMobile(context) ? 1 : 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(20),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: const SizedBox(),
                    ),
                  ),
                  Image.asset(
                    'assets/images/${Initials.i_}.png',
                    fit: isMobile(context) ? BoxFit.fitHeight : BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
