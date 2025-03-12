import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class ServicesViewPage extends StatefulWidget {
  const ServicesViewPage({super.key});

  @override
  State<ServicesViewPage> createState() => _ServicesViewPageState();
}

class _ServicesViewPageState extends State<ServicesViewPage> {
  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Consumer<PxGetDoctorData>(
        builder: (context, m, _) {
          while (m.model == null) {
            return const SizedBox();
          }
          while (m.model!.services == null || m.model!.services!.isEmpty) {
            return const NoItemsInListCard();
          }
          return ListView(
            cacheExtent: 3000,
            children: [
              SizedBox(
                height: sectionHeightHomepageViewAboutDiv(context),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: m.model!.services?.length,
                  itemBuilder: (context, index) {
                    final item = m.model!.services![index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<PxLocale>(
                        builder: (context, l, c) {
                          return InkWell(
                            onTap: () {
                              GoRouter.of(context).go(
                                  '/${l.lang}/${PageNumbers.ServicesView.i}/${item.service.id}');
                            },
                            child: Container(
                              height: isMobile(context) ? 350 : 150,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Flex(
                                direction: isMobile(context)
                                    ? Axis.vertical
                                    : Axis.horizontal,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    flex: isMobile(context) ? 3 : 1,
                                    child: Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: item.service
                                                .imageUrl(item.service.image) ??
                                            '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: isMobile(context) ? 1 : 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              l.isEnglish
                                                  ? item.service.name_en
                                                  : item.service.name_ar,
                                              style: Styles
                                                  .ARTICLETITLESTEXTSYTYLE(
                                                      context),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          if (item.service.description_en
                                                  .isNotEmpty &&
                                              item.service.description_ar
                                                  .isNotEmpty)
                                            Text(
                                              l.isEnglish
                                                  ? item.service.description_en
                                                  : item.service.description_ar,
                                              style: Styles
                                                  .ARTICLESUBTITLESTEXTSYTYLE(
                                                      context),
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        ],
                                      ),
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
