import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/models/case.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class BeforeAfterCard extends StatefulWidget {
  const BeforeAfterCard({super.key, required this.ba});
  final Case ba;

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
        ? CachedNetworkImage(
            imageUrl: (widget.ba.pre_image),
            key: const ValueKey('before'),
            fit: BoxFit.cover,
          )
        : CachedNetworkImage(
            imageUrl: (widget.ba.pre_image),
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
                          isEnglish ? widget.ba.name_en : widget.ba.name_ar,
                          style: Styles.ARTICLETITLESTEXTSYTYLE(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isEnglish
                              ? widget.ba.description_en
                              : widget.ba.description_ar,
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
