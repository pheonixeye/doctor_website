import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/models/case.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
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
  final duration =
      Duration(seconds: 5 + (3 + Random.secure().nextInt(2).toInt()).toInt());
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        number == 0 ? number = 1 : number = 0;
      });
    });
  }

  CachedNetworkImage _imageWidget(int num) {
    return num == 0
        ? CachedNetworkImage(
            imageUrl: widget.ba.imageUrl(widget.ba.pre_image) ?? '',
            key: const ValueKey('before'),
            fit: BoxFit.cover,
          )
        : CachedNetworkImage(
            imageUrl: widget.ba.imageUrl(widget.ba.post_image) ?? '',
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
      child: Consumer2<PxLocale, PxGetDoctorData>(
        builder: (context, l, m, _) {
          return Container(
            height: 300,
            width: MediaQuery.sizeOf(context).width - 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: isMobile(context) ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AnimatedSwitcher(
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.bounceOut,
                        duration: duration,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizedBox.expand(child: child),
                          );
                        },
                        child: _imageWidget(number),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: isMobile(context) ? 1 : 3,
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish ? widget.ba.name_en : widget.ba.name_ar,
                            style: Styles(m.model?.siteSettings)
                                .SUBTITLESTEXTSYTYLE(context),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l.isEnglish
                                  ? widget.ba.description_en
                                  : widget.ba.description_ar,
                              style: Styles(m.model?.siteSettings)
                                  .TEXTTEXTSYTYLE(context),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ],
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
