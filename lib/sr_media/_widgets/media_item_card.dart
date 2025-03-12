import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/functions/res_size.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return ListTile(
            leading: null,
            tileColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                l.isEnglish ? mediaItem.title_en : mediaItem.title_ar,
                style: Styles.TITLESTEXTSYTYLE(context),
              ),
            ),
            onTap: () {
              GoRouter.of(context)
                  .go('/${l.lang}/${PageNumbers.MediaView.i}/${mediaItem.id}');
            },
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: isMobile(context)
                          ? MediaQuery.sizeOf(context).width - 60
                          : MediaQuery.sizeOf(context).width * 0.5,
                      height: isMobile(context)
                          ? MediaQuery.sizeOf(context).height * 0.3
                          : MediaQuery.sizeOf(context).height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 2),
                            color: Colors.amber,
                            blurRadius: 2,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: CachedNetworkImage(
                        imageUrl: mediaItem.imageUrl(mediaItem.thumbnail) ?? '',
                        fit: BoxFit.fill,
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
  }
}
