// ignore_for_file: prefer_final_fields

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/foundation.dart';
import 'package:doctor_website/api/hx_media_item.dart';

class PxMediaGet extends ChangeNotifier {
  List<MediaItem>? _mediaItems;
  List<MediaItem>? get mediaItems => _mediaItems;

  int _page = 0;
  int get page => _page;

  Future fetchMediaItems() async {
    var m = await HxMediaItem.getMediaItems(_page);
    _mediaItems = MediaItem.mediaItemsList(m);
    notifyListeners();
  }

  Future nextPage() async {
    if (_mediaItems != null &&
        _mediaItems!.isNotEmpty &&
        !(_mediaItems!.length < 5)) {
      _page++;
      notifyListeners();
      await fetchMediaItems();
    }
  }

  Future previousPage() async {
    if (_mediaItems != null && _mediaItems!.isNotEmpty && !(_page <= 0)) {
      _page--;
      notifyListeners();
      await fetchMediaItems();
    }
  }

  Future zeroPage() async {
    _page = 0;
    notifyListeners();
    await fetchMediaItems();
  }
}
