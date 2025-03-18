import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/custom_font_icons_icons.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' as web;

class DivSocial extends StatelessWidget {
  const DivSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightSocialFooter(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.HEROCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Consumer<PxGetDoctorData>(
          builder: (context, m, _) {
            while (m.model == null || m.model!.socialContacts == null) {
              return const SizedBox();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                LinkText(
                  context.loc.follow,
                  style: Styles(m.model?.siteSettings)
                      .SUBTITLESTEXTSYTYLE(context),
                ),
                const Spacer(
                  flex: 2,
                ),
                SocialButton(
                  heroTag: 'Facebook',
                  onPressed: () {
                    web.window.open(
                      m.model!.socialContacts!.fb,
                      '_blank',
                    );
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    CustomFontIcons.facebook_squared,
                    color: Color(0xff1877F2),
                  ),
                ),
                const Spacer(),
                SocialButton(
                  heroTag: 'Instagram',
                  onPressed: () {
                    web.window.open(
                      m.model!.socialContacts!.ig,
                      '_blank',
                    );
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    CustomFontIcons.instagram,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                SocialButton(
                  heroTag: 'Youtube',
                  onPressed: () {
                    web.window.open(
                      m.model!.socialContacts!.yt,
                      '_blank',
                    );
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    CustomFontIcons.youtube_play,
                    color: Color(0xffb2071d),
                  ),
                ),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.heroTag,
    required this.child,
    required this.backgroundColor,
    required this.onPressed,
  });
  final String heroTag;
  final Widget child;
  final Color backgroundColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    //todo MOD ICONS FOR VIEW
    return Tooltip(
      message: heroTag,
      child: isMobile(context)
          ? FloatingActionButton(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              heroTag: heroTag,
              backgroundColor: backgroundColor,
              onPressed: onPressed,
              child: child,
            )
          : FloatingActionButton.large(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              heroTag: heroTag,
              backgroundColor: backgroundColor,
              onPressed: onPressed,
              child: child,
            ),
    );
  }
}
