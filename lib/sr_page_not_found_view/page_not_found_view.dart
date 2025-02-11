import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/demo_text.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/exports/exports.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:provider/provider.dart';

class PageNotFoundView extends StatelessWidget {
  const PageNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            DemoText(context.loc.page_not_found),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go(
                    '/${context.read<PxLocale>().lang}/${PageNumbers.HomeView.i}');
              },
              child: Text(context.loc.homepage),
            ),
            const Spacer(
              flex: 1,
            ),
            ...COLLECTIVEFOOTER
          ],
        ),
      ),
    );
  }
}
