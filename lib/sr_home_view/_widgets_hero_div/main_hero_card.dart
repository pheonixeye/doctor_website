import 'dart:convert';

import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/functions/res_size.dart';

import '_exp.dart';

class MainHeroCard extends StatelessWidget {
  const MainHeroCard({super.key, required this.heroItemModel});
  final HeroItemModel heroItemModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        Image.memory(
          base64Decode(heroItemModel.image),
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
              heroItemModel.description!,
            ],
          ),
        if (!isMobile(context)) ...[
          HeroTextPositioned(heroItemModel.title),
          HeroTextPositioned(heroItemModel.subtitle),
          heroItemModel.description == null
              ? const SizedBox()
              : HeroTextPositioned(heroItemModel.description!),
        ],
      ],
    );
  }
}
