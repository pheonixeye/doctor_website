import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/px_hero_items_get.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

import '../_widgets_hero_div/_exp.dart';

class DivHero extends StatefulWidget {
  const DivHero({super.key});

  @override
  State<DivHero> createState() => _DivHeroState();
}

class _DivHeroState extends State<DivHero> with AfterLayoutMixin {
  late Timer timer;
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (context.read<PxHeroItemsGet>().heroItems != null &&
          context.read<PxHeroItemsGet>().heroItems!.isNotEmpty) {
        context.read<PxHeroItemsGet>().setPage();
        pageController.animateToPage(
          context.read<PxHeroItemsGet>().page,
          duration: const Duration(seconds: 1),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await _initHeroItems();
  }

  Future _initHeroItems() async {
    await context.read<PxHeroItemsGet>().fetchHeroItems(context);
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
            Consumer<PxHeroItemsGet>(
              builder: (context, h, c) {
                while (h.heroItems == null) {
                  return const LoadingAnimationWidget();
                }
                while (h.heroItems!.isEmpty) {
                  return const NoItemsInListCard();
                }
                return PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  itemCount: h.heroItems!.length,
                  controller: pageController,
                  onPageChanged: (value) {},
                  itemBuilder: (context, index) {
                    return MainHeroCard(
                      heroItemModel: h.heroItems![index],
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
