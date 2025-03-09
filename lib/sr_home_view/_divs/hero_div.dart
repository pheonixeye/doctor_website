import 'dart:async';

import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

import '../_widgets_hero_div/_exp.dart';

class DivHero extends StatefulWidget {
  const DivHero({super.key});

  @override
  State<DivHero> createState() => _DivHeroState();
}

class _DivHeroState extends State<DivHero> {
  //TODO
  late Timer timer;
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (t) {
        pageController.nextPage(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageView(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.HEROCARDBORDER,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            //image
            Consumer<PxGetDoctorData>(
              builder: (context, m, _) {
                while (m.model == null) {
                  return const SizedBox();
                }
                while (
                    m.model!.heroItems == null || m.model!.heroItems!.isEmpty) {
                  return const NoItemsInListCard();
                }
                return PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  itemCount: m.model!.heroItems!.length,
                  controller: pageController,
                  onPageChanged: (value) {},
                  itemBuilder: (context, index) {
                    return MainHeroCard(
                      heroItemModel: m.model!.heroItems![index],
                    );
                  },
                );
              },
            ),
            //call to action
            const CallToActionColumn(),
          ],
        ),
      ),
    );
  }
}
