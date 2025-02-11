// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/functions/tr_number.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:doctor_website/exports/exports.dart';

class DivFooter extends StatelessWidget {
  const DivFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightSocialFooter(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.ABOUTCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Center(
          child: ListTile(
            title: Text(
              '${context.loc.rights_ha}'
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
                window.open(
                  'https://drkaz.dev',
                  '_blank',
                );
              },
              align: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
