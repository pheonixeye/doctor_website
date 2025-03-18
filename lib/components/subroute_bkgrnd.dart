import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/components/animated_fab.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/config/const.dart';
import 'package:provider/provider.dart';

class SubRouteBackground extends StatelessWidget {
  const SubRouteBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Consumer<PxGetDoctorData>(
        builder: (context, m, _) {
          return Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: m.model?.siteSettings == null
                ? BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/bkgrnd_${Initials.i_}.jpg'),
                      fit: BoxFit.cover,
                    ),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        '${m.model?.siteSettings?.imageUrl(m.model?.siteSettings?.website_background ?? '')}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
            child: child,
          );
        },
      ),
      floatingActionButton: const MYFAB(),
    );
  }
}
