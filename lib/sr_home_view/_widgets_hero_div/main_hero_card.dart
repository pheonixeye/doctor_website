import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/models/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/functions/res_size.dart';

import '_exp.dart';

class MainHeroCard extends StatelessWidget {
  const MainHeroCard({super.key, required this.heroItemModel});
  final HeroItem heroItemModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        CachedNetworkImage(
          imageUrl: heroItemModel.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          matchTextDirection: true,
        ),
        if (isMobile(context))
          HeroTextUnpositioned(
            heroTextList: [
              heroItemModel.title,
              heroItemModel.subtitle,
              heroItemModel.description,
            ],
          ),
        if (!isMobile(context)) ...[
          HeroTextPositioned(heroItemModel.title),
          HeroTextPositioned(heroItemModel.subtitle),
          heroItemModel.description.text_en == null
              ? const SizedBox()
              : HeroTextPositioned(heroItemModel.description),
        ],
      ],
    );
  }
}
