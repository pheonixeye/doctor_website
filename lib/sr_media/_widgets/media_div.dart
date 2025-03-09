import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/sr_media/_widgets/media_item_card.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class DivMedia extends StatefulWidget {
  const DivMedia({super.key});

  @override
  State<DivMedia> createState() => _DivMediaState();
}

class _DivMediaState extends State<DivMedia> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageViewAboutDiv(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: Styles.ABOUTCARDBORDER,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        child: Consumer<PxGetDoctorData>(
          builder: (context, m, _) {
            while (m.model == null) {
              return const SizedBox();
            }
            while (m.model!.videos == null || m.model!.videos!.isEmpty) {
              return const NoItemsInListCard();
            }
            return Column(
              children: [
                Expanded(
                  flex: 8,
                  child: ListView.builder(
                    cacheExtent: 3000,
                    addAutomaticKeepAlives: true,
                    itemCount: m.model!.videos?.length,
                    itemBuilder: (context, index) {
                      return MediaItemCard(mediaItem: m.model!.videos![index]);
                    },
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
