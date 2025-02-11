import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_category.dart';

class PxCategoriesGet extends ChangeNotifier {
  List<Category>? _categories;
  List<Category>? get categories => _categories;

  Future fetchCategories() async {
    var c = await HxCategory.fetchCategories();
    _categories = Category.categoryList(c);
    notifyListeners();
  }
}
