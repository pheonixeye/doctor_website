import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/px_before_after_list_get.dart';
import 'package:doctor_website/sr_before_after_view/_widgets/before_after_card.dart';
import 'package:provider/provider.dart';

class BeforeAfterViewPage extends StatefulWidget {
  const BeforeAfterViewPage({super.key, this.categoryId});
  final String? categoryId;

  @override
  State<BeforeAfterViewPage> createState() => _BeforeAfterViewPageState();
}

class _BeforeAfterViewPageState extends State<BeforeAfterViewPage>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await _initBeforeAfterList();
  }

  _initBeforeAfterList() async {
    await context
        .read<PxBeforeAfterListGet>()
        .fetchBeforeAfterList(widget.categoryId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: ListView(
        cacheExtent: 3000,
        children: [
          SizedBox(
            height: sectionHeightHomepageViewAboutDiv(context),
            child: Consumer<PxBeforeAfterListGet>(
              builder: (context, ba, c) {
                while (ba.beforeAfter == null) {
                  return const LoadingAnimationWidget();
                }
                while (ba.beforeAfter!.isEmpty) {
                  return const NoItemsInListCard();
                }
                return GridView.builder(
                  itemCount: ba.beforeAfter!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return BeforeAfterCard(
                      ba: ba.beforeAfter![index],
                    );
                  },
                );
              },
            ),
          ),
          ...COLLECTIVEFOOTER
        ],
      ),
    );
  }
}
