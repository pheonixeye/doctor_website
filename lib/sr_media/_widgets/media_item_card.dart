import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/models/video.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class MediaItemCard extends StatelessWidget {
  const MediaItemCard({super.key, required this.mediaItem});
  final Video mediaItem;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: Styles.CARDSHAPE,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PxLocale>(
          builder: (context, l, c) {
            return ListTile(
              leading: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: mediaItem.imageUrl(mediaItem.thumbnail) ?? '',
                  fit: BoxFit.fill,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  l.isEnglish ? mediaItem.title_en : mediaItem.title_ar,
                  style: Styles.TITLESTEXTSYTYLE(context),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l.isEnglish
                          ? mediaItem.description_en
                          : mediaItem.description_ar,
                      style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                    ),
                  ],
                ),
              ),
              onTap: () {
                GoRouter.of(context).go(
                    '/${l.lang}/${PageNumbers.MediaView.i}/${mediaItem.id}');
              },
              // children: [
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.6,
              //   child: SizedBox(
              //     height: !mediaItem.isLong
              //         ? isMobile(context)
              //             ? 300
              //             : 500
              //         : isMobile(context)
              //             ? 600
              //             : 800,
              //     child: MapViewIframe(
              //       link: mediaItem.src,
              //     ),
              //   ),
              // ),
              // ],
            );
          },
        ),
      ),
    );
  }
}
