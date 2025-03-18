import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/extensions/first_where_or_null_ext.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/sr_home_view/_widgets_contact_div/map_view.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class MediaItemViewPage extends StatefulWidget {
  const MediaItemViewPage({super.key, this.itemId});
  final String? itemId;
  @override
  State<MediaItemViewPage> createState() => _MediaItemViewPageState();
}

class _MediaItemViewPageState extends State<MediaItemViewPage> {
  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer2<PxGetDoctorData, PxLocale>(
          builder: (context, m, l, _) {
            while (m.model == null || m.model!.videos == null) {
              return const SizedBox();
            }
            final item =
                m.model!.videos!.firstWhereOrNull((v) => v.id == widget.itemId);
            while (item == null) {
              return const LoadingAnimationWidget();
            }
            return ListView(
              cacheExtent: 3000,
              addAutomaticKeepAlives: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l.isEnglish ? item.title_en : item.title_ar,
                    style: Styles(m.model?.siteSettings)
                        .SUBTITLESTEXTSYTYLE(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l.isEnglish ? item.description_en : item.description_ar,
                    style:
                        Styles(m.model?.siteSettings).TEXTTEXTSYTYLE(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: item.is_long
                        ? sectionHeightHomepageViewAboutDiv(context) * 1.6
                        : sectionHeightHomepageViewAboutDiv(context),
                    child: MapViewIframe(
                      link: item.src,
                    ),
                  ),
                ),
                ...COLLECTIVEFOOTER,
              ],
            );
          },
        ),
      ),
    );
  }
}
