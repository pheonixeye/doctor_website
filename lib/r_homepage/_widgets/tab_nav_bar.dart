import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/models/navigation_m.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/nav_index_p.dart';
import 'package:provider/provider.dart';

class NavTabBar extends StatefulWidget implements PreferredSizeWidget {
  const NavTabBar({super.key});

  @override
  State<NavTabBar> createState() => _NavTabBarState();

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _NavTabBarState extends State<NavTabBar>
    with TickerProviderStateMixin, AfterLayoutMixin {
  late final TabController _tabController;
  final _duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: context.read<PxNavIndex>().index,
      animationDuration: _duration,
      length: Pages.pages.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _tabController.animateTo(
      context.read<PxNavIndex>().index,
      duration: _duration,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxNavIndex>(
      builder: (context, l, i, c) {
        return TabBar(
          controller: _tabController,
          onTap: (value) {
            i.setIndex(value);
            GoRouter.of(context).go('/${l.lang}/${i.index}');
          },
          indicatorColor: Colors.amber,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.white,
          indicatorWeight: 3.0,
          labelPadding: const EdgeInsets.all(0),
          tabs: MxNavigation.NAVITEMS(context).map((e) {
            return Tab(
              text: e.text.data,
            );
          }).toList(),
        );
      },
    );
  }
}
