import 'package:doctor_website/extensions/first_where_or_null_ext.dart';
import 'package:doctor_website/extensions/schedule_ext.dart';
import 'package:doctor_website/providers/px_booking.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/sr_home_view/_divs/_widgets_book_div/no_clinic_selected_card.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class SelectWeekdaySection extends StatefulWidget {
  const SelectWeekdaySection({super.key});

  @override
  State<SelectWeekdaySection> createState() => _SelectWeekdaySectionState();
}

class _SelectWeekdaySectionState extends State<SelectWeekdaySection> {
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<PxGetDoctorData, PxBooking>(
      builder: (context, m, b, c) {
        while (m.model == null || m.model!.clinics == null) {
          return const LoadingAnimationWidget();
        }
        while (b.booking == null || b.booking!.clinic_id == null) {
          return const NoClinicSelectedCard();
        }
        final _selectedClinic = m.model!.clinics!
            .firstWhereOrNull((crm) => crm.clinic.id == b.booking!.clinic_id);
        return SingleChildScrollView(
          controller: _controller,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _selectedClinic!.schedule.map((e) {
              return WeekdaySelectionCard(
                schedule_id: e.id,
                onValueChanged: (id) {
                  b.setBooking(
                    schedule_id: id,
                  );
                },
                groupValue: b.booking?.schedule_id,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class WeekdaySelectionCard extends StatefulWidget {
  const WeekdaySelectionCard({
    super.key,
    required this.schedule_id,
    required this.onValueChanged,
    this.groupValue,
  });
  final String schedule_id;
  final void Function(String clinic) onValueChanged;
  final String? groupValue;

  @override
  State<WeekdaySelectionCard> createState() => _WeekdaySelectionCardState();
}

class _WeekdaySelectionCardState extends State<WeekdaySelectionCard> {
  bool isSelected = false;
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    isSelected = widget.groupValue == widget.schedule_id;
    final _sch = context
        .read<PxGetDoctorData>()
        .model!
        .clinics!
        .firstWhereOrNull(
            (c) => c.clinic.id == context.read<PxBooking>().booking!.clinic_id)!
        .schedule
        .firstWhereOrNull((s) => s.id == widget.schedule_id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer3<PxBooking, PxBookingSC, PxLocale>(
        builder: (context, b, s, l, _) {
          return GestureDetector(
            onTap: () {
              widget.onValueChanged(widget.schedule_id);
              setState(() {
                isHovering = false;
              });
              s.scrollToPage(2, context);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (event) {
                setState(() {
                  isHovering = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isHovering = false;
                });
              },
              child: Card(
                elevation: isHovering
                    ? 20
                    : isSelected
                        ? 0
                        : 10,
                shape: Styles.CARDSHAPE,
                shadowColor: isHovering ? Colors.amber : null,
                color: isHovering
                    ? Colors.amber
                    : isSelected
                        ? Colors.blue
                        : Colors.grey,
                child: Center(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _sch?.dayString(context) ?? '',
                        style: Styles.TITLESTEXTSYTYLE(context),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _sch?.scheduleString(context) ?? '',
                        style: Styles.SUBTITLESTEXTSYTYLE(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
