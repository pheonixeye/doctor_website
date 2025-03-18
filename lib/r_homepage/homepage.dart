import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/providers/nav_index_p.dart';
import 'package:doctor_website/r_homepage/_widgets/page_view_w.dart';
import 'package:doctor_website/r_homepage/_widgets/persistent_sidebar.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/r_homepage/_widgets/tab_nav_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.pageIndex = 0});
  final int? pageIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  late final ScrollController _scrollController;
  double get _logoDimentions {
    return 50;
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    context.read<PxNavIndex>().setIndex(widget.pageIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isMobile(context)) const PersistentSideBar(),
          Flexible(
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white.withOpacity(0.4),
                    foregroundColor: Colors.white.withOpacity(0.4),
                    shadowColor: Colors.transparent,
                    //! logo
                    title: Consumer2<PxLocale, PxGetDoctorData>(
                      builder: (context, l, m, _) {
                        while (m.model == null || m.model!.doctor == null) {
                          return const SizedBox();
                        }
                        final _text =
                            '${l.isEnglish ? m.model!.doctor!.prefix_en : m.model!.doctor!.prefix_ar} ${l.isEnglish ? m.model!.doctor!.name_en : m.model!.doctor!.name_ar}';
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: m.model!.doctor!
                                      .imageUrlByKey(m.model!.doctor!.logo) ??
                                  '',
                              fit: BoxFit.cover,
                              width: _logoDimentions,
                              height: _logoDimentions,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              _text,
                              style: Styles(m.model?.siteSettings)
                                  .WEBSITETITLETEXTSYTYLE(context),
                            ),
                          ],
                        );
                      },
                    ),
                    bottom: isMobile(context) ? null : const NavTabBar(),
                  ),
                ];
              },
              body: const PageViewHomepage(),
            ),
          ),
        ],
      ),
    );
  }
}
