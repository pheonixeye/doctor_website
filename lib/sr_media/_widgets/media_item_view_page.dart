import 'package:flutter/material.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/functions/time_fns.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_media_view.dart';
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
  void initState() {
    super.initState();
    _initMediaItem();
  }

  _initMediaItem() async {
    await context
        .read<PxMediaView>()
        .selectMediaItemFromServer(widget.itemId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PxMediaView>(
          builder: (context, m, c) {
            while (m.mediaItem == null) {
              return const LoadingAnimationWidget();
            }
            return Consumer<PxLocale>(
              builder: (context, l, c) {
                bool isEnglish = l.lang == 'en';
                return ListView(
                  cacheExtent: 3000,
                  addAutomaticKeepAlives: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        isEnglish ? m.mediaItem!.titleEn : m.mediaItem!.titleAr,
                        style: Styles.TITLESTEXTSYTYLE(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        isEnglish
                            ? m.mediaItem!.descriptionEn
                            : m.mediaItem!.descriptionAr,
                        style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        m.mediaItem!.timeadded.toFormattedDate(context),
                        style: Styles.TAGSTEXTSYTYLE(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: m.mediaItem!.isLong
                            ? sectionHeightHomepageViewAboutDiv(context) * 1.6
                            : sectionHeightHomepageViewAboutDiv(context),
                        child: MapViewIframe(
                          link: m.mediaItem!.src,
                        ),
                      ),
                    ),
                    ...COLLECTIVEFOOTER,
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
