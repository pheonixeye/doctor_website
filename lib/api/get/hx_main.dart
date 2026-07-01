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

  late final String _filter = 'doc_id="$doc_id"';

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<ServerResponseModel?> fetchModelById() async {
    late final Future<SiteSettings?> siteSettingsFuture;
    late final Future<List<Article>> articlesFuture;
    late final Future<List<ArticleParagraph>> paragraphsFuture;
    late final Future<List<Case>> casesFuture;
    late final Future<List<Service>> servicesFuture;
    late final Future<List<Faq>> faqsFuture;
    late final Future<List<Clinic>> clinicsFuture;
    late final Future<List<Schedule>> schedulesFuture;
    late final Future<Doctor> doctorFuture;
    late final Future<List<DoctorAbout>> doctorAboutsFuture;
    late final Future<SocialContact?> socialContactsFuture;
    late final Future<List<Video>> videosFuture;
    late final Future<List<HeroItem>> heroItemsFuture;

    siteSettingsFuture = _fetchSiteSettings();
    casesFuture = _fetchCases();
    doctorFuture = _fetchDoctor();
    doctorAboutsFuture = _fetchDoctorAbouts();
    socialContactsFuture = _fetchSocialContacts();
    videosFuture = _fetchVideos();
    heroItemsFuture = _fetchHeroItems();

    final articlesAndParagraphs = _fetchArticlesWithParagraphs();
    articlesFuture = articlesAndParagraphs.then((r) => r.$1);
    paragraphsFuture = articlesAndParagraphs.then((r) => r.$2);

    final servicesAndFaqs = _fetchServicesWithFaqs();
    servicesFuture = servicesAndFaqs.then((r) => r.$1);
    faqsFuture = servicesAndFaqs.then((r) => r.$2);

    final clinicsAndSchedules = _fetchClinicsWithSchedules();
    clinicsFuture = clinicsAndSchedules.then((r) => r.$1);
    schedulesFuture = clinicsAndSchedules.then((r) => r.$2);

    await Future.wait([
      siteSettingsFuture,
      articlesFuture,
      paragraphsFuture,
      casesFuture,
      servicesFuture,
      faqsFuture,
      clinicsFuture,
      schedulesFuture,
      doctorFuture,
      doctorAboutsFuture,
      socialContactsFuture,
      videosFuture,
      heroItemsFuture,
    ]);

    final siteSettings = await siteSettingsFuture;
    final articles = await articlesFuture;
    final paragraphs = await paragraphsFuture;
    final cases = await casesFuture;
    final services = await servicesFuture;
    final faqs = await faqsFuture;
    final clinics = await clinicsFuture;
    final schedules = await schedulesFuture;
    final doctor = await doctorFuture;
    final doctorAbouts = await doctorAboutsFuture;
    final socialContacts = await socialContactsFuture;
    final videos = await videosFuture;
    final heroItems = await heroItemsFuture;

    final articleResponseModels = articles.map((article) {
      final articleParagraphs = paragraphs
          .where((p) => p.article_id == article.id)
          .toList();
      return ArticleResponseModel(
        article: article,
        paragraphs: articleParagraphs,
      );
    }).toList();

    final serviceResponseModels = services.map((service) {
      final serviceFaqs = faqs
          .where((f) => f.service_id == service.id)
          .toList();
      return ServiceResponseModel(service: service, faqs: serviceFaqs);
    }).toList();

    final clinicResponseModels = clinics.map((clinic) {
      final clinicSchedules = schedules
          .where((s) => s.clinic_id == clinic.id)
          .toList();
      return ClinicResponseModel(
        clinic: clinic,
        schedule: clinicSchedules,
        offDates: clinic.off_dates ?? [],
      );
    }).toList();

    return ServerResponseModel(
      articles: articleResponseModels,
      cases: cases,
      services: serviceResponseModels,
      clinics: clinicResponseModels,
      doctor: doctor,
      doctorAbouts: doctorAbouts,
      socialContacts: socialContacts,
      videos: videos,
      heroItems: heroItems,
      siteSettings: siteSettings,
    );
  }

  Future<SiteSettings?> _fetchSiteSettings() async {
    try {
      final record = await _client
          .collection('site_settings')
          .getFirstListItem(_filter);
      return SiteSettings.fromJson(record.toJson());
    } catch (_) {
      return null;
    }
  }

  Future<Doctor> _fetchDoctor() async {
    final record = await _client.collection('doctors').getOne(doc_id);
    return Doctor.fromJson(record.toJson());
  }

  Future<List<DoctorAbout>> _fetchDoctorAbouts() async {
    final records = await _client
        .collection('doctor_about')
        .getFullList(filter: _filter);
    return records.map((r) => DoctorAbout.fromJson(r.toJson())).toList();
  }

  Future<SocialContact?> _fetchSocialContacts() async {
    try {
      final record = await _client
          .collection('social_contacts')
          .getFirstListItem(_filter);
      return SocialContact.fromJson(record.toJson());
    } catch (_) {
      return null;
    }
  }

  Future<List<Video>> _fetchVideos() async {
    final records = await _client
        .collection('videos')
        .getFullList(filter: _filter);
    return records.map((r) => Video.fromJson(r.toJson())).toList();
  }

  Future<List<HeroItem>> _fetchHeroItems() async {
    final records = await _client
        .collection('hero_items')
        .getFullList(filter: _filter);
    return records.map((r) => HeroItem.fromJson(r.toJson())).toList();
  }

  Future<List<Case>> _fetchCases() async {
    final records = await _client
        .collection('cases')
        .getFullList(filter: _filter);
    return records.map((r) => Case.fromJson(r.toJson())).toList();
  }

  Future<(List<Article>, List<ArticleParagraph>)>
  _fetchArticlesWithParagraphs() async {
    final articleRecords = await _client
        .collection('articles')
        .getFullList(filter: _filter);
    final articles = articleRecords
        .map((r) => Article.fromJson(r.toJson()))
        .toList();

    final articleIds = articles.map((a) => a.id).toList();
    final paragraphFilters = articleIds
        .map((id) => 'article_id="$id"')
        .join(' || ');
    final paragraphs = articleIds.isEmpty
        ? <ArticleParagraph>[]
        : await _client
              .collection('article_paragraphs')
              .getFullList(filter: paragraphFilters)
              .then(
                (records) => records
                    .map((r) => ArticleParagraph.fromJson(r.toJson()))
                    .toList(),
              );

    return (articles, paragraphs);
  }

  Future<(List<Service>, List<Faq>)> _fetchServicesWithFaqs() async {
    final serviceRecords = await _client
        .collection('services')
        .getFullList(filter: _filter);
    final services = serviceRecords
        .map((r) => Service.fromJson(r.toJson()))
        .toList();

    final serviceIds = services.map((s) => s.id).toList();
    final faqFilters = serviceIds.map((id) => 'service_id="$id"').join(' || ');
    final faqs = serviceIds.isEmpty
        ? <Faq>[]
        : await _client
              .collection('faqs')
              .getFullList(filter: faqFilters)
              .then(
                (records) =>
                    records.map((r) => Faq.fromJson(r.toJson())).toList(),
              );

    return (services, faqs);
  }

  Future<(List<Clinic>, List<Schedule>)> _fetchClinicsWithSchedules() async {
    final clinicRecords = await _client
        .collection('clinics')
        .getFullList(filter: _filter);
    final clinics = clinicRecords
        .map((r) => Clinic.fromJson(r.toJson()))
        .toList();

    final clinicIds = clinics.map((c) => c.id).toList();
    final scheduleFilters = clinicIds
        .map((id) => 'clinic_id="$id"')
        .join(' || ');
    final schedules = clinicIds.isEmpty
        ? <Schedule>[]
        : await _client
              .collection('schedules')
              .getFullList(filter: scheduleFilters)
              .then(
                (records) =>
                    records.map((r) => Schedule.fromJson(r.toJson())).toList(),
              );

    return (clinics, schedules);
  }
}

class HxMainSupabase implements HxMain {
  HxMainSupabase({required this.doc_id});

  final String doc_id;

  final _client = DataSourceHelper.ds as SupabaseClient;

  @override
  Future<ServerResponseModel?> fetchModelById() async {
    final params = {'doctor_id': doc_id};

    final _siteSettingsRequest = await _client
        .from('site_settings')
        .select()
        .eq('doc_id', doc_id);

    final _siteSettings = SiteSettings.fromJson(_siteSettingsRequest.first);

    final _articlesRequest = await _client
        .rpc('get_articles', params: params)
        .select();

    final _articlesResponseModel = _articlesRequest.map((a) {
      return ArticleResponseModel(
        article: Article.fromJson(a),
        paragraphs: (a['paragraphs'] as List<dynamic>)
            .map((p) => ArticleParagraph.fromJson(p))
            .toList(),
      );
    }).toList();

    final _casesRequest = await _client
        .from('cases')
        .select()
        .eq('doc_id', doc_id);

    final _cases = _casesRequest.map((c) => Case.fromJson(c)).toList();

    final _servicesRequest = await _client
        .rpc('get_services', params: params)
        .select();

    final _servicesResponseModel = _servicesRequest.map((s) {
      return ServiceResponseModel(
        service: Service.fromJson(s),
        faqs:
            (s['faqs'] as List<dynamic>?)
                ?.map((f) => Faq.fromJson(f))
                .toList() ??
            [],
      );
    }).toList();

    final _clinicsRequest = await _client
        .rpc('get_clinics', params: params)
        .select();

    final _clinicsResponseModel = _clinicsRequest.map((c) {
      return ClinicResponseModel(
        clinic: Clinic.fromJson(c),
        schedule:
            (c['schedules'] as List<dynamic>?)
                ?.map((s) => Schedule.fromJson(s))
                .toList() ??
            [],
        offDates: [],
      );
    }).toList();

    final _doctorRequest = await _client
        .from('doctors')
        .select()
        .eq('id', doc_id);

    final _doctor = Doctor.fromJson(_doctorRequest.first);

    final _docAboutRequest = await _client
        .from('doctor_about')
        .select()
        .eq('doc_id', doc_id);

    final _docAbouts = _docAboutRequest
        .map((a) => DoctorAbout.fromJson(a))
        .toList();

    final _socialContactsRequest = await _client
        .from('social_contacts')
        .select()
        .eq('doc_id', doc_id);

    final _socialContacts = SocialContact.fromJson(
      _socialContactsRequest.first,
    );

    final _videosRequest = await _client
        .from('videos')
        .select()
        .eq('doc_id', doc_id);

    final _videos = _videosRequest.map((v) => Video.fromJson(v)).toList();

    final _heroItemsRequest = await _client
        .from('hero_items')
        .select()
        .eq('doc_id', doc_id);

    final _heroItems = _heroItemsRequest
        .map((h) => HeroItem.fromJson(h))
        .toList();

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
    // print('HxMainSupabase().fetchModelById($doc_id)');
    return _model;
  }
}
