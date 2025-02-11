import 'dart:convert';

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/styles/styles.dart';

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
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: Styles.CONTAINERDECORATION,
            alignment: Alignment.center,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                if (widget.e.articleImage != null)
                  Image.memory(
                    base64Decode(widget.e.articleImage!),
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
                        widget.e.title,
                        style: Styles.ARTICLETITLESTEXTSYTYLE(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (widget.e.shortDescription != null)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.e.shortDescription!,
                            style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.e.tags.map((e) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: LinkText(
                              e,
                              style: Styles.TAGSTEXTSYTYLE(),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
