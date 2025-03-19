import 'package:doctor_website/extensions/first_where_or_null_ext.dart';
import 'package:doctor_website/providers/px_booking.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
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
    final _clinic = context
        .read<PxGetDoctorData>()
        .model!
        .clinics!
        .firstWhereOrNull((crm) =>
            crm.clinic.id == context.read<PxBooking>().booking!.clinic_id);
    final _sch = _clinic!.schedule;
    final _selectedSch = _sch.firstWhereOrNull(
        (s) => s.id == context.read<PxBooking>().booking!.schedule_id);
    var startingday = _selectedSch?.intday;

    while (NOW.weekday != startingday) {
      NOW = NOW.add(const Duration(days: 1));
    }
    return NOW;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<PxGetDoctorData, PxBooking, PxBookingSC, PxLocale>(
      builder: (context, m, b, sc, l, _) {
        while (m.model == null || m.model!.clinics == null) {
          return const LoadingAnimationWidget();
        }
        while (b.booking == null ||
            b.booking!.clinic_id == null ||
            b.booking!.clinic_id!.isEmpty) {
          return NoClinicSelectedCard(
            style: Styles(m.model?.siteSettings).SUBTITLESTEXTSYTYLE(context),
          );
        }
        while (
            b.booking!.schedule_id == null || b.booking!.schedule_id!.isEmpty) {
          return NoDaySelectedCard(
            style: Styles(m.model?.siteSettings).SUBTITLESTEXTSYTYLE(context),
          );
        }
        return Card.outlined(
          elevation: 0,
          shape: Styles.CARDSHAPE,
          color: Colors.blue.shade200,
          child: Theme(
            data: Theme.of(context).copyWith(
              platform: TargetPlatform.iOS,
              colorScheme: const ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textTheme: Theme.of(context).primaryTextTheme.copyWith(
                    bodySmall: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      locale: l.locale,
                    ),
                  ),
              iconTheme: const IconThemeData(
                color: Colors.black,
                size: 50,
              ),
            ),
            child: CalendarDatePicker(
              initialDate: getstartingdate(),
              firstDate: getstartingdate(),
              currentDate: DateTime.tryParse(b.booking!.date ?? ''),
              lastDate: NOW.add(const Duration(days: 356)),
              selectableDayPredicate: (datetime) {
                final _clinic = m.model!.clinics!.firstWhereOrNull(
                    (crm) => crm.clinic.id == b.booking!.clinic_id);
                final _sch = _clinic!.schedule;
                final _selectedSch = _sch
                    .firstWhereOrNull((s) => s.id == b.booking!.schedule_id);
                if (_selectedSch == null) {
                  return false;
                }
                if (datetime.weekday == _selectedSch.intday) {
                  return true;
                } else {
                  return false;
                }
              },
              onDateChanged: (value) async {
                final sDate = DateTime(value.year, value.month, value.day);
                b.setBooking(date: sDate.toIso8601String());
                await Future.delayed(const Duration(milliseconds: 200))
                    .then((value) {
                  if (context.mounted) {
                    sc.nxtPage(context);
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }
}
