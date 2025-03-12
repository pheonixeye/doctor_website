// ignore: avoid_web_libraries_in_flutter
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' as w;

import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/functions/tr_number.dart';
import 'package:doctor_website/styles/styles.dart';

class DivFooter extends StatelessWidget {
  const DivFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightSocialFooter(context),
      child: Consumer2<PxLocale, PxGetDoctorData>(
        builder: (context, l, m, _) {
          while (m.model == null || m.model!.doctor == null) {
            return const SizedBox();
          }
          final text =
              '${context.loc.rights} ${l.isEnglish ? m.model!.doctor!.prefix_en : m.model!.doctor!.prefix_ar} ${l.isEnglish ? m.model!.doctor!.name_en : m.model!.doctor!.name_ar}';
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            shape: Styles.ABOUTCARDBORDER,
            color: Styles.MAINPAGECOMPONENTCARDCOLOR,
            child: Center(
              child: ListTile(
                title: Text(
                  '$text'
                  ' ${trNumber(DateTime.now().year, context)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                subtitle: LinkText(
                  context.loc.design,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    w.window.open(
                      'https://drkaz.dev',
                      '_blank',
                    );
                  },
                  align: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
