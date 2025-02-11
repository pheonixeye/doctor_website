import 'package:flutter/material.dart';

class PxNavIndex extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void setIndex(int val) {
    _index = val;
    notifyListeners();
  }
}
