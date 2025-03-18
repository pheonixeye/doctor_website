import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' as web;

class DivPhone extends StatelessWidget {
  const DivPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxGetDoctorData>(
      builder: (context, l, m, c) {
        while (m.model == null) {
          return const LoadingAnimationWidget();
        }
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
                  style: Styles(m.model?.siteSettings)
                      .SUBTITLESTEXTSYTYLE(context),
                ),
                const Spacer(),
                Builder(
                  builder: (context) {
                    final number = m.model!.socialContacts!.main_phone;
                    List<int> parsed =
                        number.characters.map(int.parse).toList();
                    bool isEnglish = l.lang == 'en';
                    List<String> no =
                        parsed.map((e) => ArabicNumbers().convert(e)).toList();
                    String arno = no.fold<String>('', (p, e) => p + e);

                    return LinkText(
                      isEnglish ? number : arno,
                      style:
                          Styles(m.model?.siteSettings).TEXTTEXTSYTYLE(context),
                      onTap: () {
                        web.window.open(
                          'tel:+2$number',
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
      },
    );
  }
}
