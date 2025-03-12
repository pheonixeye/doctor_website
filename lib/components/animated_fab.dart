import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/fab.dart';
import 'package:doctor_website/custom_font_icons_icons.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/nav_index_p.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' as html; // ignore: avoid_web_libraries_in_flutter

class MYFAB extends StatelessWidget {
  const MYFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<PxLocale, PxNavIndex, PxGetDoctorData>(
      builder: (context, l, i, m, _) {
        while (m.model == null || m.model!.socialContacts == null) {
          return const LoadingAnimationWidget();
        }
        return AnimatedFloatingActionButton(
          fabButtons: [
            FloatingActionButton(
              shape: const CircleBorder(),
              heroTag: 'locale${i.index}${DateTime.now().toIso8601String()}',
              child: const Icon(Icons.language),
              onPressed: () {
                l.changeLocale();
                i.setIndex(i.index);
                GoRouter.of(context).go('/${l.lang!}/${i.index}');
              },
            ),
            FloatingActionButton(
              shape: const CircleBorder(),
              heroTag: 'whatsapp${i.index}${DateTime.now().toIso8601String()}',
              child: const Icon(CustomFontIcons.whatsapp),
              onPressed: () {
                html.window.open(
                  ' https://wa.me/+2${m.model!.socialContacts!.main_wa}',
                  '_blank',
                );
              },
            ),
            FloatingActionButton(
              shape: const CircleBorder(),
              heroTag: 'call${i.index}${DateTime.now().toIso8601String()}',
              child: const Icon(Icons.call),
              onPressed: () {
                html.window.open(
                  'tel:+2${m.model!.socialContacts!.main_phone}',
                  '_blank',
                );
              },
            ),
          ],
          animatedIconData: AnimatedIcons.menu_close,
        );
      },
    );
  }
}
