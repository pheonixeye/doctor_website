import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/extensions/first_where_or_null_ext.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class ArticleViewPage extends StatefulWidget {
  const ArticleViewPage({
    super.key,
    required this.articleid,
  });
  final String? articleid;

  @override
  State<ArticleViewPage> createState() => _ArticleViewPageState();
}

class _ArticleViewPageState extends State<ArticleViewPage> {
  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer2<PxLocale, PxGetDoctorData>(
          builder: (context, l, m, _) {
            while (m.model == null || m.model!.articles == null) {
              return const LoadingAnimationWidget();
            }
            final item = m.model!.articles!
                .firstWhereOrNull((e) => e.article.id == widget.articleid);
            return ListView(
              cacheExtent: 3000,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l.isEnglish
                        ? item?.article.title_en ?? ''
                        : item?.article.title_ar ?? '',
                    style: Styles.ARTICLETITLESTEXTSYTYLE(context),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (item!.article.description_en.isNotEmpty &&
                    item.article.description_ar.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      l.isEnglish
                          ? item.article.description_en
                          : item.article.description_ar,
                      style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (item.article.thumbnail.isNotEmpty)
                  Card(
                    elevation: 10,
                    shape: Styles.CARDSHAPE,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CachedNetworkImage(
                      imageUrl: (item.article.thumbnail),
                      fit: BoxFit.fill,
                    ),
                  ),
                ...item.paragraphs.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      shape: Styles.CARDSHAPE,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      child: ListTile(
                        tileColor: Colors.white24,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish ? e.title_en : e.title_ar,
                            style: Styles.TITLESTEXTSYTYLE(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish ? e.body_en : e.body_ar,
                            style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                ...COLLECTIVEFOOTER,
              ],
            );
          },
        ),
      ),
    );
  }
}
