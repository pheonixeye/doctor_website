import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_article_view.dart';
import 'package:doctor_website/providers/px_articles_get.dart';
import 'package:doctor_website/sr_articles/_widgets/article_card.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class DivArticles extends StatefulWidget {
  const DivArticles({super.key});

  @override
  State<DivArticles> createState() => _DivArticlesState();
}

class _DivArticlesState extends State<DivArticles> with AfterLayoutMixin {
  final duration = const Duration(milliseconds: 400);
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxArticlesGet>().fetchArticles(context);
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageViewAboutDiv(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.ABOUTCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Consumer<PxArticlesGet>(
          builder: (context, a, c) {
            while (a.articles == null) {
              return const LoadingAnimationWidget();
            }
            while (a.articles!.isEmpty) {
              return const NoItemsInListCard();
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: ClickableListWheelScrollView(
                    scrollController: scrollController,
                    itemHeight: isMobile(context) ? 300 : 500,
                    itemCount: a.articles!.length,
                    onItemTapCallback: (index) {
                      context
                          .read<PxArticleView>()
                          .selectArticle(a.articles![index]);
                      GoRouter.of(context).push(
                          '/${context.read<PxLocale>().lang}/${PageNumbers.ArticlesView.i}/${a.articles![index].id}');
                    },
                    child: ListWheelScrollView.useDelegate(
                      scrollBehavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          //! Allows to swipe in web browsers
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      itemExtent: isMobile(context) ? 300 : 500,
                      controller: scrollController,
                      perspective: 0.001,
                      physics: const FixedExtentScrollPhysics(),
                      offAxisFraction: 0.0,
                      squeeze: 1.0,
                      overAndUnderCenterOpacity: 1.0,
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final e = a.articles![index];
                          return ArticleCard(
                            e: e,
                          );
                        },
                        childCount: a.articles!.length,
                      ),
                      onSelectedItemChanged: (value) async {
                        await a.setIndex(value, context);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
