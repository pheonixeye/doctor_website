import 'package:doctor_website/components/collective_footer.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/providers/exp_opacity_p.dart';
import 'package:doctor_website/sr_media/_widgets/media_div.dart';
import 'package:provider/provider.dart';

class MediaView extends StatelessWidget {
  const MediaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxExpOpacity>(
      builder: (context, e, c) {
        return Opacity(
          opacity: e.exp ? 0.0 : 1.0,
          child: ListView(
            cacheExtent: 3000,
            children: const [
              DivMedia(),
              ...COLLECTIVEFOOTER,
            ],
          ),
        );
      },
    );
  }
}
