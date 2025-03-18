import 'package:doctor_website/api/common/common.dart';
import 'package:doctor_website/models/article.dart';
import 'package:doctor_website/models/article_paragraph.dart';
import 'package:doctor_website/models/article_response_model.dart';
import 'package:doctor_website/models/case.dart';
import 'package:doctor_website/models/clinic.dart';
import 'package:doctor_website/models/clinic_response_model.dart';
import 'package:doctor_website/models/doctor.dart';
import 'package:doctor_website/models/doctor_about.dart';
import 'package:doctor_website/models/faq.dart';
import 'package:doctor_website/models/hero_item.dart';
import 'package:doctor_website/models/schedule.dart';
import 'package:doctor_website/models/server_response_model.dart';
import 'package:doctor_website/models/service.dart';
import 'package:doctor_website/models/service_response_model.dart';
import 'package:doctor_website/models/site_settings.dart';
import 'package:doctor_website/models/social_contact.dart';
import 'package:doctor_website/models/video.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HxMain {
  const HxMain();

  static final DataSourceHelper _helper = DataSourceHelper();

  Future<ServerResponseModel?> fetchModelById();

  factory HxMain.common(String doc_id) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxMainPocketbase(doc_id: doc_id),
      DataSource.sb => HxMainSupabase(doc_id: doc_id),
    };
  }
}

class HxMainPocketbase implements HxMain {
  HxMainPocketbase({required this.doc_id});

  final String doc_id;

  static const String _expand = '';

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<ServerResponseModel?> fetchModelById() async {
    await _client.collection('doctors').getOne(
          doc_id,
          expand: _expand,
        );

    return null;
  }
}

class HxMainSupabase implements HxMain {
  HxMainSupabase({required this.doc_id});

  final String doc_id;

  final _client = DataSourceHelper.ds as SupabaseClient;

  @override
  Future<ServerResponseModel?> fetchModelById() async {
    final params = {
      'doctor_id': doc_id,
    };

    final _siteSettingsRequest =
        await _client.from('site_settings').select().eq('doc_id', doc_id);

    final _siteSettings = SiteSettings.fromJson(_siteSettingsRequest.first);

    final _articlesRequest = await _client
        .rpc(
          'get_articles',
          params: params,
        )
        .select();

    final _articlesResponseModel = _articlesRequest.map((a) {
      return ArticleResponseModel(
        article: Article.fromJson(a),
        paragraphs: (a['paragraphs'] as List<dynamic>)
            .map((p) => ArticleParagraph.fromJson(p))
            .toList(),
      );
    }).toList();

    final _casesRequest =
        await _client.from('cases').select().eq('doc_id', doc_id);

    final _cases = _casesRequest.map((c) => Case.fromJson(c)).toList();

    final _servicesRequest = await _client
        .rpc(
          'get_services',
          params: params,
        )
        .select();

    final _servicesResponseModel = _servicesRequest.map((s) {
      return ServiceResponseModel(
        service: Service.fromJson(s),
        faqs: (s['faqs'] as List<dynamic>?)
                ?.map((f) => Faq.fromJson(f))
                .toList() ??
            [],
      );
    }).toList();

    final _clinicsRequest =
        await _client.rpc('get_clinics', params: params).select();

    final _clinicsResponseModel = _clinicsRequest.map((c) {
      return ClinicResponseModel(
        clinic: Clinic.fromJson(c),
        schedule: (c['schedules'] as List<dynamic>?)
                ?.map((s) => Schedule.fromJson(s))
                .toList() ??
            [],
        offDates: [],
      );
    }).toList();

    final _doctorRequest =
        await _client.from('doctors').select().eq('id', doc_id);

    final _doctor = Doctor.fromJson(_doctorRequest.first);

    final _docAboutRequest =
        await _client.from('doctor_about').select().eq('doc_id', doc_id);

    final _docAbouts =
        _docAboutRequest.map((a) => DoctorAbout.fromJson(a)).toList();

    final _socialContactsRequest =
        await _client.from('social_contacts').select().eq('doc_id', doc_id);

    final _socialContacts =
        SocialContact.fromJson(_socialContactsRequest.first);

    final _videosRequest =
        await _client.from('videos').select().eq('doc_id', doc_id);

    final _videos = _videosRequest.map((v) => Video.fromJson(v)).toList();

    final _heroItemsRequest =
        await _client.from('hero_items').select().eq('doc_id', doc_id);

    final _heroItems =
        _heroItemsRequest.map((h) => HeroItem.fromJson(h)).toList();

    final _model = ServerResponseModel(
      articles: _articlesResponseModel,
      cases: _cases,
      services: _servicesResponseModel,
      clinics: _clinicsResponseModel,
      doctor: _doctor,
      doctorAbouts: _docAbouts,
      socialContacts: _socialContacts,
      videos: _videos,
      heroItems: _heroItems,
      siteSettings: _siteSettings,
    );
    print('HxMainSupabase().fetchModelById($doc_id)');
    return _model;
  }
}
