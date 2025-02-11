import 'dart:convert';

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/functions/time_fns.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_media_view.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class MediaItemCard extends StatelessWidget {
  const MediaItemCard({super.key, required this.mediaItem});
  final MediaItem mediaItem;
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
            bool isEnglish = l.lang == 'en';
            return ListTile(
              leading: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image(
                  image: MemoryImage(
                    base64Decode(mediaItem.thumbnail),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isEnglish ? mediaItem.titleEn : mediaItem.titleAr,
                  style: Styles.TITLESTEXTSYTYLE(context),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isEnglish
                          ? mediaItem.descriptionEn
                          : mediaItem.descriptionAr,
                      style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mediaItem.timeadded.toFormattedDate(context),
                        style: Styles.TAGSTEXTSYTYLE(),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                context.read<PxMediaView>().selectMediaItem(mediaItem);
                GoRouter.of(context).push(
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
