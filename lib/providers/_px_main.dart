import 'package:doctor_website/providers/exp_opacity_p.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/nav_index_p.dart';
import 'package:doctor_website/providers/px_article_view.dart';
import 'package:doctor_website/providers/px_articles_get.dart';
import 'package:doctor_website/providers/px_before_after_list_get.dart';
import 'package:doctor_website/providers/px_booking_make.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/providers/px_categories_get.dart';
import 'package:doctor_website/providers/px_clinics_get.dart';
import 'package:doctor_website/providers/px_hero_items_get.dart';
import 'package:doctor_website/providers/px_media_get.dart';
import 'package:doctor_website/providers/px_media_view.dart';
import 'package:doctor_website/providers/px_service_one_get.dart';
import 'package:doctor_website/providers/px_services_get.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocale()),
  ChangeNotifierProvider(create: (context) => PxNavIndex()),
  ChangeNotifierProvider(create: (context) => PxExpOpacity()),
  ChangeNotifierProvider(create: (context) => PxHeroItemsGet()),
  ChangeNotifierProvider(create: (context) => PxClinicGet()),
  ChangeNotifierProvider(create: (context) => PxBookingMake()),
  ChangeNotifierProvider(create: (context) => PxBookingSC()),
  ChangeNotifierProvider(create: (context) => PxArticlesGet()),
  ChangeNotifierProvider(create: (context) => PxArticleView()),
  ChangeNotifierProvider(create: (context) => PxMediaGet()),
  ChangeNotifierProvider(create: (context) => PxMediaView()),
  ChangeNotifierProvider(create: (context) => PxServicesGet()),
  ChangeNotifierProvider(create: (context) => PxOneServiceGet()),
  ChangeNotifierProvider(create: (context) => PxCategoriesGet()),
  ChangeNotifierProvider(create: (context) => PxBeforeAfterListGet()),
];
