import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/extensions/model_ext.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_booking_make.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/providers/px_clinics_get.dart';
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
    return Consumer2<PxClinicGet, PxBookingMake>(
      builder: (context, cl, b, c) {
        while (cl.clinics == null || cl.clinics!.isEmpty) {
          return const LoadingAnimationWidget();
        }
        while (b.clinic == null) {
          return const NoClinicSelectedCard();
        }
        return SingleChildScrollView(
          controller: _controller,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: b.clinic!.schedule.map((e) {
              return WeekdaySelectionCard(
                schedule: e,
                onValueChanged: (sch) {
                  b.setDay(sch);
                },
                groupValue: b.day,
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
    required this.schedule,
    required this.onValueChanged,
    this.groupValue,
  });
  final Schedule schedule;
  final void Function(Schedule clinic) onValueChanged;
  final Schedule? groupValue;

  @override
  State<WeekdaySelectionCard> createState() => _WeekdaySelectionCardState();
}

class _WeekdaySelectionCardState extends State<WeekdaySelectionCard> {
  bool isSelected = false;
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    isSelected = widget.groupValue == widget.schedule;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer3<PxBookingMake, PxBookingSC, PxLocale>(
        builder: (context, b, s, l, c) {
          return GestureDetector(
            onTap: () {
              widget.onValueChanged(widget.schedule);
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
                        widget.schedule.dayString(context),
                        style: Styles.TITLESTEXTSYTYLE(context),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.schedule.scheduleString(context),
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
