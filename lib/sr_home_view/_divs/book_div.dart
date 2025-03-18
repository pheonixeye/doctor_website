import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/sr_home_view/_divs/_widgets_book_div/booking_confirmed_section.dart';
import 'package:doctor_website/sr_home_view/_divs/_widgets_book_div/creds_confirm_section.dart';
import 'package:doctor_website/sr_home_view/_divs/_widgets_book_div/select_clinic_section.dart';
import 'package:doctor_website/sr_home_view/_divs/_widgets_book_div/select_date_section.dart';
import 'package:doctor_website/sr_home_view/_divs/_widgets_book_div/select_weekday.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class DivBookApp extends StatelessWidget {
  const DivBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sectionHeightHomepageView(context),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        color: Styles.MAINPAGECOMPONENTCARDCOLOR,
        shape: Styles.HEROCARDBORDER,
        child: Consumer2<PxBookingSC, PxGetDoctorData>(
          builder: (context, p, m, _) {
            return Column(
              children: [
                Center(
                  child: Text(
                    context.loc.book_app,
                    style:
                        Styles(m.model?.siteSettings).TITLESTEXTSYTYLE(context),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: p.pageController,
                    children: const [
                      // select clinic
                      SelectClinicSection(),
                      // select weekday
                      SelectWeekdaySection(),
                      // select date
                      SelectDateSection(),
                      // enter credentials & confirm
                      EnterCredentialsConfirmBookingSection(),
                      // booking confirmed
                      BookingConfirmedSection(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: 'prv',
                      child: const Icon(Icons.arrow_back),
                      onPressed: () {
                        p.prevPage(context);
                      },
                    ),
                    FloatingActionButton.extended(
                      heroTag: p.page,
                      onPressed: null,
                      label: Center(
                        child: Text(p.info),
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: 'nxt',
                      child: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        p.nxtPage(context);
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
