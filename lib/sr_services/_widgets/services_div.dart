import 'package:flutter/material.dart';
import 'package:doctor_website/constant/male_female.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/sr_services/_widgets/s_category_card.dart';
import 'package:doctor_website/styles/styles.dart';

class DivServices extends StatelessWidget {
  const DivServices({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageViewAboutDiv(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.ABOUTCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Flex(
          direction: isMobile(context) ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: MF.MFL
              .map((e) => ServicesCategoryCard(
                    category: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
