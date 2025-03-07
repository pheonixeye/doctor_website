import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
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
            return const LoadingAnimationWidget();
          }
          while (m.model!.services == null || m.model!.services!.isEmpty) {
            return const NoItemsInListCard();
          }
          return ListView(
            cacheExtent: 3000,
            children: [
              SizedBox(
                height: sectionHeightHomepageViewAboutDiv(context),
                child: GridView.builder(
                  itemCount: m.model!.services?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    final item = m.model!.services![index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<PxLocale>(
                        builder: (context, l, c) {
                          bool isEnglish = l.lang == 'en';
                          return InkWell(
                            onTap: () {
                              GoRouter.of(context).push(
                                  '/${l.lang}/${PageNumbers.ServicesView.i}/${item.service.id}');
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
                                    child: CachedNetworkImage(
                                      imageUrl: item.service.image,
                                      fit: BoxFit.cover,
                                      matchTextDirection: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isEnglish
                                          ? item.service.name_en
                                          : item.service.name_ar,
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
