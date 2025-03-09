// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';

class PxBookingSC extends ChangeNotifier {
  static const Duration duration = Duration(seconds: 1);
  static const Curve curve = Curves.ease;

  int _page = 0;
  int get page => _page;

  final PageController? _pageController = PageController();
  PageController? get pageController => _pageController;

  void nxtPage(BuildContext context) {
    _page == 3 ? _page : _page++;
    notifyListeners();
    switchInfo(context);
    _pageController!.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
    notifyListeners();
  }

  void scrollToPage(int p, BuildContext context) {
    _page = p;
    switchInfo(context);
    _pageController!.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
    notifyListeners();
  }

  void prevPage(BuildContext context) {
    _page <= 0 ? _page : _page--;
    switchInfo(context);
    _pageController!.animateToPage(
      page,
      duration: duration,
      curve: curve,
    );
    notifyListeners();
  }

  String _info = 'Select Clinic - اختر العيادة';
  String get info => _info;

  void switchInfo(BuildContext context) {
    switch (page) {
      case 1:
        _info = context.loc.select_weekday;
        notifyListeners();
        break;
      case 2:
        _info = context.loc.select_day;
        notifyListeners();
        break;
      case 3:
        _info = context.loc.select_info;
        notifyListeners();
        break;
      case 4:
        _info = context.loc.booking_confirmed;
        notifyListeners();
        break;
      default:
        _info = context.loc.select_clinic;
        notifyListeners();
        break;
    }
  }
}
