import 'package:flutter/material.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/models/navigation_m.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/nav_index_p.dart';
import 'package:provider/provider.dart';

class PageViewHomepage extends StatefulWidget {
  const PageViewHomepage({super.key});

  @override
  State<PageViewHomepage> createState() => _PageViewHomepageState();
}

class _PageViewHomepageState extends State<PageViewHomepage> {
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxNavIndex>(
      builder: (context, i, c) {
        return PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: isMobile(context) ? Axis.vertical : Axis.horizontal,
          controller: _pageController,
          itemCount: MxNavigation.NAVITEMS(context).length,
          itemBuilder: (context, index) {
            return Pages.pages[i.index];
          },
        );
      },
    );
  }
}
