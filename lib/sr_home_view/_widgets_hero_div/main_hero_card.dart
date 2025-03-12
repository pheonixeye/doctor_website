import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/models/hero_item.dart';
import 'package:flutter/material.dart';

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
        isMobile(context)
            ? heroItemModel.image_mobile.isEmpty
                ? const SizedBox()
                : CachedNetworkImage(
                    imageUrl: heroItemModel.image_mobile,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    matchTextDirection: false,
                  )
            : heroItemModel.image_other.isEmpty
                ? const SizedBox()
                : CachedNetworkImage(
                    imageUrl: heroItemModel.image_other,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    matchTextDirection: false,
                  ),
        HeroTextPositioned(heroItemModel.title),
        HeroTextPositioned(heroItemModel.subtitle),
        HeroTextPositioned(heroItemModel.description),
      ],
    );
  }
}
