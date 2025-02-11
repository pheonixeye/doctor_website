import 'dart:async';
import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_services_get.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class ServicesViewPage extends StatefulWidget {
  const ServicesViewPage({super.key, required this.mfId});
  final String? mfId;

  @override
  State<ServicesViewPage> createState() => _ServicesViewPageState();
}

class _ServicesViewPageState extends State<ServicesViewPage>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await _initServices();
  }

  _initServices() async {
    if (widget.mfId != null) {
      await context.read<PxServicesGet>().fetchServices(widget.mfId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Consumer<PxServicesGet>(
        builder: (context, s, c) {
          while (s.services == null) {
            return const LoadingAnimationWidget();
          }
          while (s.services!.isEmpty) {
            return const NoItemsInListCard();
          }
          return ListView(
            cacheExtent: 3000,
            children: [
              SizedBox(
                height: sectionHeightHomepageViewAboutDiv(context),
                child: GridView.builder(
                  itemCount: s.services!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<PxLocale>(
                        builder: (context, l, c) {
                          bool isEnglish = l.lang == 'en';
                          return InkWell(
                            onTap: () {
                              GoRouter.of(context).push(
                                  '/${l.lang}/${PageNumbers.ServicesView.i}/${widget.mfId}/${s.services![index].id}');
                            },
                            child: Card(
                              color: Colors.transparent,
                              elevation: 20,
                              shape: Styles.CARDSHAPE,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Image.memory(
                                      base64Decode(s.services![index].image),
                                      fit: BoxFit.cover,
                                      matchTextDirection: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isEnglish
                                          ? s.services![index].titleEn
                                          : s.services![index].titleAr,
                                      style: Styles.ARTICLETITLESTEXTSYTYLE(
                                          context),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              ...COLLECTIVEFOOTER
            ],
          );
        },
      ),
    );
  }
}
