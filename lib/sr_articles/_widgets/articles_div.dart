import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/sr_articles/_widgets/article_card.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class DivArticles extends StatefulWidget {
  const DivArticles({super.key});

  @override
  State<DivArticles> createState() => _DivArticlesState();
}

class _DivArticlesState extends State<DivArticles> {
  final duration = const Duration(milliseconds: 400);
  late final ScrollController scrollController;

  int selected = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageViewAboutDiv(context),
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.ABOUTCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Consumer<PxGetDoctorData>(
          builder: (context, m, _) {
            while (m.model == null) {
              return const SizedBox();
            }
            while (m.model!.articles == null || m.model!.articles!.isEmpty) {
              return const NoItemsInListCard();
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ListView.builder(
                  cacheExtent: 3000,
                  controller: scrollController,
                  itemCount: m.model!.articles!.length,
                  itemBuilder: (context, index) {
                    final e = m.model!.articles![index];
                    return ArticleCard(
                      e: e.article,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
