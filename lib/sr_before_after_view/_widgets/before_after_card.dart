import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class BeforeAfterCard extends StatefulWidget {
  const BeforeAfterCard({super.key, required this.ba});
  final BeforeAfter ba;

  @override
  State<BeforeAfterCard> createState() => _BeforeAfterCardState();
}

class _BeforeAfterCardState extends State<BeforeAfterCard> {
  int number = 0;
  late Timer _timer;
  final duration = const Duration(seconds: 5);
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(duration * (3.5 + Random.secure().nextDouble()),
        (timer) {
      setState(() {
        number == 0 ? number = 1 : number = 0;
      });
    });
  }

  _imageWidget(int num) {
    return num == 0
        ? Image.memory(
            base64Decode(widget.ba.beforeImg),
            key: const ValueKey('before'),
            fit: BoxFit.cover,
          )
        : Image.memory(
            base64Decode(widget.ba.afterImg),
            key: const ValueKey('after'),
            fit: BoxFit.cover,
          );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<PxLocale>(
        builder: (context, l, c) {
          bool isEnglish = l.lang == 'en';
          return InkWell(
            onTap: () {
              if (widget.ba.mediaItemId != null) {
                GoRouter.of(context).go(
                    '/${l.lang}/${PageNumbers.MediaView.i}/${widget.ba.mediaItemId}');
              }
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              shape: Styles.CARDSHAPE,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      return AnimatedSwitcher(
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.bounceOut,
                        duration: duration,
                        child: _imageWidget(number),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: SizedBox.expand(child: child),
                          );
                        },
                      );
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isEnglish ? widget.ba.titleEn : widget.ba.titleAr,
                          style: Styles.ARTICLETITLESTEXTSYTYLE(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isEnglish
                              ? widget.ba.descriptionEn
                              : widget.ba.descriptionAr,
                          style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
