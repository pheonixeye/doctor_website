import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/functions/time_fns.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/sr_home_view/_divs/_widgets_book_div/no_clinic_selected_card.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class SelectDateSection extends StatefulWidget {
  const SelectDateSection({super.key});

  @override
  State<SelectDateSection> createState() => _SelectDateSectionState();
}

class _SelectDateSectionState extends State<SelectDateSection> {
  DateTime getstartingdate() {
    var startingday = context.read<PxBookingMake>().day!.intDay;

    while (NOW.weekday != startingday) {
      NOW = NOW.add(const Duration(days: 1));
    }
    return NOW;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<PxClinicGet, PxBookingMake, PxBookingSC, PxLocale>(
      builder: (context, cl, b, sc, l, c) {
        while (cl.clinics == null || cl.clinics!.isEmpty) {
          return const LoadingAnimationWidget();
        }
        while (b.clinic == null) {
          return const NoClinicSelectedCard();
        }
        while (b.day == null) {
          return const NoDaySelectedCard();
        }
        return Card(
          elevation: 10,
          shape: Styles.CARDSHAPE,
          color: Colors.transparent,
          child: Theme(
            data: Theme.of(context).copyWith(
              platform: TargetPlatform.iOS,
              colorScheme: const ColorScheme.light(
                primary: Colors.white,
                onPrimary: Colors.black,
                onSurface: Colors.white,
              ),
              textTheme: Theme.of(context).primaryTextTheme.copyWith(
                    bodySmall: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      locale: l.locale,
                    ),
                  ),
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 50,
              ),
            ),
            child: CalendarDatePicker(
              initialDate: getstartingdate(),
              firstDate: getstartingdate(),
              lastDate: NOW.add(const Duration(days: 356)),
              selectableDayPredicate: (datetime) {
                final List<DateTime> offDates =
                    b.clinic!.offDates.map((e) => DateTime.parse(e)).toList();
                if (b.day!.intDay == datetime.weekday) {
                  return true;
                } else if (offDates.contains(datetime)) {
                  return false;
                } else {
                  return false;
                }
              },
              onDateChanged: (value) async {
                final sDate = DateTime(value.year, value.month, value.day);
                b.setdate(sDate.toIso8601String());
                await Future.delayed(const Duration(milliseconds: 200))
                    .then((value) {
                  sc.nxtPage(context);
                });
              },
            ),
          ),
        );
      },
    );
  }
}
