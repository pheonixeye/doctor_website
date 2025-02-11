import 'package:flutter/material.dart';
import 'package:doctor_website/components/divider.dart';
import 'package:doctor_website/providers/exp_opacity_p.dart';
import 'package:doctor_website/sr_articles/_widgets/articles_div.dart';
import 'package:doctor_website/sr_home_view/_divs/footer_div.dart';
import 'package:doctor_website/sr_home_view/_divs/phone_div.dart';
import 'package:doctor_website/sr_home_view/_divs/social_div.dart';
import 'package:provider/provider.dart';

class ArticlesView extends StatelessWidget {
  const ArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxExpOpacity>(
      builder: (context, e, c) {
        return Opacity(
          opacity: e.exp ? 0.0 : 1.0,
          child: ListView(
            cacheExtent: 3000,
            children: const [
              DivArticles(),
              GlobalDivider(),
              DivSocial(),
              GlobalDivider(),
              DivPhone(),
              GlobalDivider(),
              DivFooter(),
            ],
          ),
        );
      },
    );
  }
}
