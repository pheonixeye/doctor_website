import 'dart:async';
import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_categories_get.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class DivCategories extends StatefulWidget {
  const DivCategories({super.key, this.forServices = false});
  final bool forServices;

  @override
  State<DivCategories> createState() => _DivCategoriesState();
}

class _DivCategoriesState extends State<DivCategories> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await _initCategories();
  }

  Future _initCategories() async {
    await context.read<PxCategoriesGet>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageViewAboutDiv(context),
      child: Consumer2<PxCategoriesGet, PxLocale>(
        builder: (context, cat, l, c) {
          bool isEnglish = l.lang == 'en';
          while (cat.categories == null) {
            return const LoadingAnimationWidget();
          }
          while (cat.categories!.isEmpty) {
            return const NoItemsInListCard();
          }
          return GridView.builder(
            itemCount: cat.categories!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    if (widget.forServices) {
                      GoRouter.of(context).push(
                          '/${l.lang}/${PageNumbers.ServicesView.i}/${cat.categories![index].titleEn}');
                    } else {
                      GoRouter.of(context).push(
                          '/${l.lang}/${PageNumbers.BeforeAfterView.i}/${cat.categories![index].id}');
                    }
                  },
                  child: Card(
                    elevation: 10,
                    shape: Styles.CARDSHAPE,
                    child: Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: [
                        Image.memory(
                          base64Decode(cat.categories![index].thumbnail),
                        ),
                        Text(
                          isEnglish
                              ? cat.categories![index].titleEn
                              : cat.categories![index].titleAr,
                          style: Styles.ARTICLETITLESTEXTSYTYLE(context),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
