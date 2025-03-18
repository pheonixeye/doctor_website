import 'package:doctor_website/functions/shell_function.dart';
import 'package:doctor_website/providers/px_booking.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class BookingConfirmedSection extends StatelessWidget {
  const BookingConfirmedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<PxBookingSC, PxBooking, PxGetDoctorData>(
      builder: (context, sc, b, m, _) {
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
                    style: Styles(m.model?.siteSettings)
                        .SUBTITLESTEXTSYTYLE(context),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.loc.thanks_ha,
                style:
                    Styles(m.model?.siteSettings).SUBTITLESTEXTSYTYLE(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.loc.to_contact,
                style:
                    Styles(m.model?.siteSettings).SUBTITLESTEXTSYTYLE(context),
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
                        await shellFunction(
                          context,
                          toExecute: () {
                            b.resetBooking();
                            if (context.mounted) {
                              sc.scrollToPage(0, context);
                            }
                          },
                        );
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
