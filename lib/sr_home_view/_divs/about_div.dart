import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

const mFont = TextStyle(
  fontSize: 14,
  color: Colors.amber,
);
const oFont = TextStyle(
  fontSize: 22,
  color: Colors.amber,
);

TextStyle _tStyle(BuildContext context) {
  return isMobile(context) ? mFont : oFont;
}

class DivAbout extends StatelessWidget {
  const DivAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageViewAboutDiv(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.ABOUTCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Consumer2<PxGetDoctorData, PxLocale>(
          builder: (context, m, l, _) {
            while (m.model == null) {
              return SizedBox();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: isMobile(context) ? 1 : 3,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          context.loc.about,
                          textAlign: TextAlign.start,
                          style: Styles.SUBTITLESTEXTSYTYLE(context),
                        ),
                      ),
                      ...m.model!.doctorAbouts!.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish ? e.about_en : e.about_ar,
                            style: _tStyle(context),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Expanded(
                  flex: isMobile(context) ? 1 : 2,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Colors.white.withOpacity(0.8),
                          ),
                          child: const SizedBox(),
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl: m.model!.doctor!
                                .imageUrlByKey(m.model!.doctor!.avatar) ??
                            '',
                        fit: isMobile(context)
                            ? BoxFit.fitHeight
                            : BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
