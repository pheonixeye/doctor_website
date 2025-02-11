import 'dart:async';
import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_service_one_get.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class OneServiceViewPage extends StatefulWidget {
  const OneServiceViewPage({super.key, required this.serviceId});
  final String? serviceId;
  @override
  State<OneServiceViewPage> createState() => _OneServiceViewPageState();
}

class _OneServiceViewPageState extends State<OneServiceViewPage>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    _initService();
  }

  _initService() async {
    await context
        .read<PxOneServiceGet>()
        .fetchOneServiceFromServer(widget.serviceId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Consumer<PxOneServiceGet>(
        builder: (context, s, c) {
          while (s.service == null) {
            return const LoadingAnimationWidget();
          }
          return Consumer<PxLocale>(
            builder: (context, l, c) {
              bool isEnglish = l.lang == 'en';
              return ListView(
                cacheExtent: 3000,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isEnglish ? s.service!.titleEn : s.service!.titleAr,
                      style: Styles.TITLESTEXTSYTYLE(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isEnglish
                          ? s.service!.descriptionEn
                          : s.service!.descriptionAr,
                      style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: sectionHeightHomepageViewAboutDiv(context),
                      child: Card(
                        elevation: 10,
                        shape: Styles.CARDSHAPE,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.memory(
                          base64Decode(s.service!.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  ...s.service!.faqs.map(
                    (e) => ExpansionTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber.shade300,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(3, 3),
                              spreadRadius: 3,
                              blurRadius: 3,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isEnglish ? e.questionEn : e.questionAr,
                          style: Styles.ARTICLETITLESTEXTSYTYLE(context),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isEnglish ? e.answerEn : e.answerAr,
                            style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                          ),
                        ),
                        e.mediaItemId != null
                            ? LinkText(
                                context.loc.media,
                                style: Styles.TITLESTEXTSYTYLE(context),
                                onTap: () {
                                  GoRouter.of(context).go(
                                      '/${l.lang}/${PageNumbers.MediaView.i}/${e.mediaItemId!}');
                                },
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  ...COLLECTIVEFOOTER
                ],
              );
            },
          );
        },
      ),
    );
  }
}
