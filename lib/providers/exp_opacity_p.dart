import 'package:flutter/material.dart';

class PxExpOpacity extends ChangeNotifier {
  bool _exp = false;
  bool get exp => _exp;

  void toggle() {
    _exp = !_exp;
    notifyListeners();
  }
}
