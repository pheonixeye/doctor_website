import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/fab.dart';
import 'package:doctor_website/config/const.dart';
import 'package:doctor_website/custom_font_icons_icons.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/nav_index_p.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter

class MYFAB extends StatelessWidget {
  const MYFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      fabButtons: [
        Consumer2<PxLocale, PxNavIndex>(
          builder: (context, l, i, c) {
            return FloatingActionButton(
              shape: const CircleBorder(),
              heroTag: 'l',
              child: const Icon(Icons.language),
              onPressed: () {
                l.changeLocale();
                i.setIndex(i.index);
                GoRouter.of(context).go('/${l.lang!}/${i.index}');
              },
            );
          },
        ),
        FloatingActionButton(
          shape: const CircleBorder(),
          heroTag: 'whatsapp',
          child: const Icon(CustomFontIcons.whatsapp),
          onPressed: () {
            //TODO: WHATSAPP
            html.window.open(
              ' https://wa.me/+2${DoctorStaticData.current().whatsapp}',
              '_blank',
            );
          },
        ),
        FloatingActionButton(
          shape: const CircleBorder(),
          heroTag: 'call',
          child: const Icon(Icons.call),
          onPressed: () {
            //TODO: CALL
            html.window.open(
              'tel:+2${DoctorStaticData.current().call}',
              '_blank',
            );
          },
        ),
      ],
      animatedIconData: AnimatedIcons.menu_close,
    );
  }
}
