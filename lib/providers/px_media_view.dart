import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/api/hx_media_item.dart';

class PxMediaView extends ChangeNotifier {
  MediaItem? _mediaItem;
  MediaItem? get mediaItem => _mediaItem;

  void selectMediaItem(MediaItem? item) {
    _mediaItem = item;
    notifyListeners();
  }

  Future selectMediaItemFromServer(String id) async {
    if (_mediaItem != null) {
      // print('returning...Media Item already loaded...');
      return;
    }
    // print('fetching from server in one second...');
    await Future.delayed(const Duration(seconds: 1)).whenComplete(() async {
      var m = await HxMediaItem.fetchOneMediaItem(id);
      _mediaItem = MediaItem.fromJson(m);
      notifyListeners();
    });
  }
}
