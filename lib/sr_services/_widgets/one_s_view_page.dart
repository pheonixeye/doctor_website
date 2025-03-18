import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/extensions/first_where_or_null_ext.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/models/service_response_model.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class OneServiceViewPage extends StatefulWidget {
  const OneServiceViewPage({super.key, required this.serviceId});
  final String? serviceId;
  @override
  State<OneServiceViewPage> createState() => _OneServiceViewPageState();
}

class _OneServiceViewPageState extends State<OneServiceViewPage> {
  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Consumer<PxGetDoctorData>(
        builder: (context, m, _) {
          late final ServiceResponseModel? item;
          while (m.model == null || m.model?.services == null) {
            return const LoadingAnimationWidget();
          }
          item = m.model!.services!
              .firstWhereOrNull((s) => s.service.id == widget.serviceId);
          while (item == null) {
            return const SizedBox();
          }
          return Consumer<PxLocale>(
            builder: (context, l, c) {
              return ListView(
                cacheExtent: 3000,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      l.isEnglish
                          ? item!.service.name_en
                          : item!.service.name_ar,
                      style: Styles(m.model?.siteSettings)
                          .SUBTITLESTEXTSYTYLE(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      l.isEnglish
                          ? item.service.description_en
                          : item.service.description_ar,
                      style:
                          Styles(m.model?.siteSettings).TEXTTEXTSYTYLE(context),
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
                        child: CachedNetworkImage(
                          imageUrl:
                              item.service.imageUrl(item.service.image) ?? '',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  ...item.faqs.map(
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
                          l.isEnglish ? e.q_en : e.q_ar,
                          style: Styles(m.model?.siteSettings)
                              .SUBTITLESTEXTSYTYLE(context),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish ? e.a_en : e.a_ar,
                            style: Styles(m.model?.siteSettings)
                                .TEXTTEXTSYTYLE(context),
                          ),
                        ),
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
