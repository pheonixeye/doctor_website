import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/models/article.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({super.key, required this.e});
  final Article e;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).go(
            '/${context.read<PxLocale>().lang}/${PageNumbers.ArticlesView.i}/${widget.e.id}');
      },
      child: Container(
        height: isMobile(context) ? 100 : 200,
        width: MediaQuery.sizeOf(context).width - 100,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer2<PxLocale, PxGetDoctorData>(
            builder: (context, l, m, _) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Hero(
                        tag: widget.e.id,
                        key: ValueKey(widget.e.id),
                        child: CachedNetworkImage(
                          imageUrl: widget.e.imageUrl(widget.e.thumbnail) ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish ? widget.e.title_en : widget.e.title_ar,
                            style: Styles(m.model?.siteSettings)
                                .SUBTITLESTEXTSYTYLE(context),
                          ),
                        ),
                        (widget.e.description_ar.isNotEmpty &&
                                widget.e.description_en.isNotEmpty)
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    l.isEnglish
                                        ? widget.e.description_en
                                        : widget.e.description_ar,
                                    style: Styles(m.model?.siteSettings)
                                        .TEXTTEXTSYTYLE(context),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: isMobile(context) ? 4 : 3,
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
