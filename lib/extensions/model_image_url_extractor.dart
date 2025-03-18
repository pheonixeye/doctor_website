import 'package:doctor_website/api/common/common.dart';
import 'package:doctor_website/models/article.dart';
import 'package:doctor_website/models/case.dart';
import 'package:doctor_website/models/doctor.dart';
import 'package:doctor_website/models/hero_item.dart';
import 'package:doctor_website/models/service.dart';
import 'package:doctor_website/models/site_settings.dart';
import 'package:doctor_website/models/video.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String _baseUrlPocketbase({
  required String collection,
  required String id,
  required String fileKey,
}) {
  final _url =
      "${(DataSourceHelper.ds as PocketBase).baseURL}/api/files/$collection/$id/$fileKey?thumb=200x200";
  // print(_url);
  return _url;
}

String _baseUrlSupabase({
  required String collection,
  required String id,
  required String fileKey,
}) {
  final _url = (DataSourceHelper.ds as SupabaseClient)
      .storage
      .from(collection)
      .getPublicUrl(fileKey);
  // print(_url);
  return _url;
}

extension ImageUrlExtractorDoctor on Doctor {
  String? imageUrlByKey(String fileKey) => fileKey.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'doctors',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}

extension ImageUrlExtractorService on Service {
  String? imageUrl(String fileKey) => fileKey.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'services',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}

extension ImageUrlExtractorVideo on Video {
  String? imageUrl(String fileKey) => thumbnail.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'videos',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}

extension ImageUrlExtractorCase on Case {
  String? imageUrl(String fileKey) => fileKey.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'cases',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}

extension ImageUrlExtractorArticle on Article {
  String? imageUrl(String fileKey) => thumbnail.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'articles',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}

extension ImageUrlExtractorHeroItem on HeroItem {
  String? imageUrl(String fileKey) => fileKey.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'hero_items',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}

extension ImageUrlExtractorSiteSettings on SiteSettings {
  String? imageUrl(String fileKey) => fileKey.isEmpty
      ? null
      : switch (DataSourceHelper().dataSource) {
          DataSource.pb => _baseUrlPocketbase(
              collection: 'site-settings',
              id: id,
              fileKey: fileKey,
            ),
          DataSource.sb => _baseUrlSupabase(
              collection: 'base',
              id: id,
              fileKey: fileKey,
            ),
        };
}
