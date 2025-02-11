import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_before_after.dart';

class PxBeforeAfterListGet extends ChangeNotifier {
  List<BeforeAfter>? _beforeAfter;
  List<BeforeAfter>? get beforeAfter => _beforeAfter;

  Future fetchBeforeAfterList(String categoryId) async {
    var ba = await HxBeforeAfter.getBeforeAfter(categoryId);
    _beforeAfter = BeforeAfter.listBA(ba);
    notifyListeners();
  }
}
