// ignore: avoid_web_libraries_in_flutter
// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

import '../_widgets_contact_div/_exp.dart' deferred as wids;

class DivContact extends StatefulWidget {
  const DivContact({super.key});

  @override
  State<DivContact> createState() => _DivContactState();
}

class _DivContactState extends State<DivContact> {
  late final Timer timer;
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
    wids.loadLibrary();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
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
              return Consumer2<PxGetDoctorData, PxLocale>(
                builder: (context, m, l, c) {
                  while (m.model == null) {
                    return const LoadingAnimationWidget();
                  }
                  while (
                      m.model!.clinics == null || m.model!.clinics!.isEmpty) {
                    return const NoItemsInListCard();
                  }
                  return PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: m.model!.clinics!.length,
                    controller: pageController,
                    onPageChanged: (value) {},
                    itemBuilder: (context, index) {
                      // String venue = l.lang == 'en'
                      //     ? '${cl.clinics![index].govEn} - ${cl.clinics![index].distEn} - ${cl.clinics![index].venueEn}'
                      //     : '${cl.clinics![index].govAr} - ${cl.clinics![index].distAr} - ${cl.clinics![index].venueAr}';
                      String address = l.isEnglish
                          ? m.model!.clinics![index].clinic.address_en
                          : m.model!.clinics![index].clinic.address_ar;
                      return Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: wids.MapViewIframe(
                              link:
                                  m.model!.clinics![index].clinic.location_link,
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
                                    schedule: m.model!.clinics![index].schedule,
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
              return Consumer2<PxGetDoctorData, PxLocale>(
                builder: (context, m, l, c) {
                  while (m.model == null) {
                    return const LoadingAnimationWidget();
                  }
                  while (
                      m.model!.clinics == null || m.model!.clinics!.isEmpty) {
                    return const NoItemsInListCard();
                  }
                  return PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: m.model!.clinics!.length,
                    controller: pageController,
                    onPageChanged: (value) {},
                    itemBuilder: (context, index) {
                      String address = l.lang == 'en'
                          ? m.model!.clinics![index].clinic.address_en
                          : m.model!.clinics![index].clinic.address_ar;
                      return Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: wids.MapViewIframe(
                              link:
                                  m.model!.clinics![index].clinic.location_link,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                wids.AddressTile(
                                  address: address,
                                ),
                                wids.HoursTile(
                                  schedule: m.model!.clinics![index].schedule,
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
