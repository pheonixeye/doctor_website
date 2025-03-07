import 'package:doctor_website/api/get/hx_main.dart';
import 'package:doctor_website/constant/constants.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/r_homepage/homepage.dart';
import 'package:doctor_website/r_main_route_page/main_route_page.dart';
import 'package:doctor_website/sr_articles/_widgets/article_view_page.dart';
import 'package:doctor_website/sr_before_after_view/_widgets/bas_view_page.dart';
import 'package:doctor_website/sr_media/_widgets/media_item_view_page.dart';
import 'package:doctor_website/sr_page_not_found_view/page_not_found_view.dart';
import 'package:doctor_website/sr_services/_widgets/one_s_view_page.dart';
import 'package:doctor_website/sr_services/_widgets/s_view_page.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  refreshListenable: PxLocale(),
  routes: [
    GoRoute(
      path: '/',
      name: 'mainroutepage',
      builder: (context, state) {
        return MainRoutePage(
          key: state.pageKey,
        );
      },
      redirect: (context, GoRouterState state) {
        if (state.fullPath == '/') {
          return '/ar/0';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: ':lang/:id',
          name: 'homepage',
          builder: (context, state) {
            final lang = state.pathParameters['lang'] as String;
            context.read<PxLocale>().setLang(lang);
            final key = ValueKey(lang);

            final pageStr = state.pathParameters['id'] as String;
            final page = int.parse(pageStr);
            final valueKeyIndex = ValueKey(page);
            return MainRoutePage(
              key: key,
              child: ChangeNotifierProvider.value(
                value: PxGetDoctorData(
                  service: HxMain.common(dotenv.env[AppConstants.DOC_ID]!),
                ),
                child: HomePage(
                  key: valueKeyIndex,
                  pageIndex: page,
                ),
              ),
            );
          },
          redirect: (context, state) {
            if (state.pathParameters.length == 1) {
              return '/${state.pathParameters['lang']}/0';
            }
            if (int.parse(state.pathParameters['id']!) > 7) {
              return '/${state.pathParameters['lang']}/0';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: ':itemid',
              name: 'itemviewroute',
              builder: (context, state) {
                //todo: conditionize according to page number / return error route on wrong number
                //todo: use switch
                final pageId = state.pathParameters['id'];
                if (pageId == null) {
                  return PageNotFoundView(
                    key: state.pageKey,
                  );
                }
                switch (pageId) {
                  case '2':
                    return ServicesViewPage(
                      key: state.pageKey,
                    );

                  case '3':
                    return BeforeAfterViewPage(
                      key: state.pageKey,
                    );

                  case '4':
                    final String? mediaItemId = state.pathParameters['itemid'];
                    return MediaItemViewPage(
                      key: state.pageKey,
                      itemId: mediaItemId,
                    );
                  case '5':
                    final String? articleid = state.pathParameters['itemid'];
                    return ArticleViewPage(
                      key: state.pageKey,
                      articleid: articleid,
                    );

                  default:
                    return PageNotFoundView(
                      key: state.pageKey,
                    );
                }
              },
              routes: [
                GoRoute(
                  path: ':serviceid',
                  builder: (context, state) {
                    final pageId = state.pathParameters['id'];
                    final serviceId = state.pathParameters['serviceid'];
                    if (pageId != null && pageId == '2') {
                      return OneServiceViewPage(
                        key: state.pageKey,
                        serviceId: serviceId,
                      );
                    }
                    return PageNotFoundView(
                      key: state.pageKey,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
