// ignore_for_file: prefer_final_fields

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_hero_item.dart';
import 'package:doctor_website/functions/res_size.dart';

class PxHeroItemsGet extends ChangeNotifier {
  List<HeroItemModel>? _heroItems;
  List<HeroItemModel>? get heroItems => _heroItems;

  Future fetchHeroItems(BuildContext context) async {
    var i =
        await HxHeroItem.fetchAllHeroItems(isMobile(context) ? true : false);
    _heroItems = HeroItemModel.heroList(i);
    notifyListeners();
  }

  int _page = 0;
  int get page => _page;

  void setPage() {
    _page == heroItems!.length ? _page = 0 : _page++;
  }
}
