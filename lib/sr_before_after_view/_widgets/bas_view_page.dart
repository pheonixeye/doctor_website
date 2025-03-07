import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/collective_footer.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/components/subroute_bkgrnd.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/sr_before_after_view/_widgets/before_after_card.dart';
import 'package:provider/provider.dart';

class BeforeAfterViewPage extends StatefulWidget {
  const BeforeAfterViewPage({super.key});

  @override
  State<BeforeAfterViewPage> createState() => _BeforeAfterViewPageState();
}

class _BeforeAfterViewPageState extends State<BeforeAfterViewPage> {
  @override
  Widget build(BuildContext context) {
    return SubRouteBackground(
      child: ListView(
        cacheExtent: 3000,
        children: [
          SizedBox(
            height: sectionHeightHomepageViewAboutDiv(context),
            child: Consumer<PxGetDoctorData>(
              builder: (context, m, c) {
                while (m.model == null) {
                  return const LoadingAnimationWidget();
                }
                while (m.model!.cases == null || m.model!.cases!.isEmpty) {
                  return const NoItemsInListCard();
                }
                return GridView.builder(
                  itemCount: m.model!.cases?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = m.model!.cases![index];

                    return BeforeAfterCard(
                      ba: item,
                    );
                  },
                );
              },
            ),
          ),
          ...COLLECTIVEFOOTER
        ],
      ),
    );
  }
}
