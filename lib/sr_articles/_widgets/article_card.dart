import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/models/article.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/styles/styles.dart';
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
    return RotatedBox(
      quarterTurns: 1,
      child: Card(
        elevation: 10,
        shape: Styles.CARDSHAPE,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxLocale>(
            builder: (context, l, _) {
              return Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: Styles.CONTAINERDECORATION,
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    if (widget.e.thumbnail.isEmpty)
                      CachedNetworkImage(
                        imageUrl: (widget.e.thumbnail),
                        fit: BoxFit.fill,
                      ),
                    Container(
                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish ? widget.e.title_en : widget.e.title_ar,
                            style: Styles.ARTICLETITLESTEXTSYTYLE(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (widget.e.description_ar.isNotEmpty &&
                            widget.e.description_en.isNotEmpty)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                l.isEnglish
                                    ? widget.e.description_en
                                    : widget.e.description_ar,
                                style:
                                    Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
