import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_articles.dart';

class PxArticleView extends ChangeNotifier {
  Article? _article;
  Article? get article => _article;

  void selectArticle(Article? a) {
    _article = a;
    notifyListeners();
  }

  Future selectArticleFromServer(String id) async {
    if (_article != null) {
      // print('returning...article already loaded...');
      return;
    }
    // print('fetching from server in one second...');
    await Future.delayed(const Duration(seconds: 1)).whenComplete(() async {
      var a = await HxArticles.fetchOneArticleById(id);
      _article = Article.fromJson(a);
      notifyListeners();
    });
  }
}
