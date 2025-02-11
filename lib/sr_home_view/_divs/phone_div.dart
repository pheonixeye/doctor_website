import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/config/const.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter

class DivPhone extends StatelessWidget {
  const DivPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightSocialFooter(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: const RoundedRectangleBorder(),
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Row(
          children: [
            const Spacer(),
            Text(
              context.loc.phone,
              style: Styles.TITLESTEXTSYTYLE(context),
            ),
            const Spacer(),
            Consumer<PxLocale>(
              builder: (context, l, c) {
                final number = DoctorStaticData.current().call;
                List<int> parsed = number.characters.map(int.parse).toList();
                bool isEnglish = l.lang == 'en';
                List<String> no =
                    parsed.map((e) => ArabicNumbers().convert(e)).toList();
                String arno = no.fold<String>('', (p, e) => p + e);

                return LinkText(
                  isEnglish ? number : arno,
                  style: Styles.TITLESTEXTSYTYLE(context),
                  onTap: () {
                    //TODO: CALL
                    html.window.open(
                      'tel:+2${DoctorStaticData.current().call}',
                      '_blank',
                    );
                  },
                );
              },
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
