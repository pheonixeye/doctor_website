import 'package:doctor_website/providers/px_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class BookingConfirmedSection extends StatelessWidget {
  const BookingConfirmedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxBookingSC, PxBooking>(
      builder: (context, sc, b, c) {
        return Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                shape: Styles.CARDSHAPE,
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    context.loc.booking_confirmed,
                    style: Styles.TITLESTEXTSYTYLE(context),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.loc.thanks_ha,
                style: Styles.SUBTITLESTEXTSYTYLE(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.loc.to_contact,
                style: Styles.SUBTITLESTEXTSYTYLE(context),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 24,
                    ),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.calendar_month),
                      label: Text(context.loc.book_app),
                      onPressed: () async {
                        await EasyLoading.show(status: context.loc.loading)
                            .then((value) {
                          b.resetBooking();
                          if (context.mounted) {
                            sc.scrollToPage(0, context);
                          }
                        }).then((value) async {
                          await EasyLoading.dismiss();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
