// ignore: avoid_web_libraries_in_flutter
// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_clinics_get.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

import '../_widgets_contact_div/_exp.dart' deferred as wids;

class DivContact extends StatefulWidget {
  const DivContact({super.key});

  @override
  State<DivContact> createState() => _DivContactState();
}

class _DivContactState extends State<DivContact> with AfterLayoutMixin {
  late final Timer timer;
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
    wids.loadLibrary();
    pageController = PageController();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (context.read<PxClinicGet>().clinics != null &&
          context.read<PxClinicGet>().clinics!.isNotEmpty) {
        context.read<PxClinicGet>().setPage();
        pageController.animateToPage(
          context.read<PxClinicGet>().page,
          duration: const Duration(seconds: 3),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await _initClinics();
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  Future _initClinics() async {
    await context.read<PxClinicGet>().fetchClinics();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageViewAboutDiv(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.ABOUTCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Builder(
          builder: (context) {
            if (isMobile(context)) {
              return Consumer2<PxClinicGet, PxLocale>(
                builder: (context, cl, l, c) {
                  while (cl.clinics == null) {
                    return const LoadingAnimationWidget();
                  }
                  while (cl.clinics!.isEmpty) {
                    return const NoItemsInListCard();
                  }
                  return PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cl.clinics!.length,
                    controller: pageController,
                    onPageChanged: (value) {},
                    itemBuilder: (context, index) {
                      // String venue = l.lang == 'en'
                      //     ? '${cl.clinics![index].govEn} - ${cl.clinics![index].distEn} - ${cl.clinics![index].venueEn}'
                      //     : '${cl.clinics![index].govAr} - ${cl.clinics![index].distAr} - ${cl.clinics![index].venueAr}';
                      String address = l.lang == 'en'
                          ? cl.clinics![index].addressEn
                          : cl.clinics![index].addressAr;
                      return Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: wids.MapViewIframe(
                              link: cl.clinics![index].locationEmbedLink,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // wids.VenueTile(
                                      //   venue: venue,
                                      // ),
                                      wids.AddressTile(
                                        address: address,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: wids.HoursTile(
                                    schedule: cl.clinics![index].schedule,
                                    hasSpecialSchedule:
                                        cl.clinics![index].hasSpecialSchedule,
                                    ssEn: cl.clinics![index].specialScheduleEn,
                                    ssAr: cl.clinics![index].specialScheduleAr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            } else {
              return Consumer2<PxClinicGet, PxLocale>(
                builder: (context, cl, l, c) {
                  while (cl.clinics == null) {
                    return const LoadingAnimationWidget();
                  }
                  while (cl.clinics!.isEmpty) {
                    return const NoItemsInListCard();
                  }
                  return PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cl.clinics!.length,
                    controller: pageController,
                    onPageChanged: (value) {},
                    itemBuilder: (context, index) {
                      String venue = l.lang == 'en'
                          ? '${cl.clinics![index].govEn} - ${cl.clinics![index].distEn} - ${cl.clinics![index].venueEn}'
                          : '${cl.clinics![index].govAr} - ${cl.clinics![index].distAr} - ${cl.clinics![index].venueAr}';
                      String address = l.lang == 'en'
                          ? cl.clinics![index].addressEn
                          : cl.clinics![index].addressAr;
                      return Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: wids.MapViewIframe(
                              link: cl.clinics![index].locationEmbedLink,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                wids.VenueTile(
                                  venue: venue,
                                ),
                                wids.AddressTile(
                                  address: address,
                                ),
                                wids.HoursTile(
                                  schedule: cl.clinics![index].schedule,
                                  hasSpecialSchedule:
                                      cl.clinics![index].hasSpecialSchedule,
                                  ssEn: cl.clinics![index].specialScheduleEn,
                                  ssAr: cl.clinics![index].specialScheduleAr,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
