import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:doctor_website_models/doctor_website__models.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_booking_make.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/providers/px_clinics_get.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class SelectClinicSection extends StatefulWidget {
  const SelectClinicSection({super.key});

  @override
  State<SelectClinicSection> createState() => _SelectClinicSectionState();
}

class _SelectClinicSectionState extends State<SelectClinicSection>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _initClinics();
  }

  Future _initClinics() async {
    await context.read<PxClinicGet>().fetchClinics();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxClinicGet, PxBookingMake>(
      builder: (context, cl, b, c) {
        while (cl.clinics == null) {
          return const LoadingAnimationWidget();
        }
        while (cl.clinics!.isEmpty) {
          return const NoItemsInListCard();
        }
        return Flex(
          direction: isMobile(context) ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: cl.clinics!.map((e) {
            return Expanded(
              child: ClinicSelectionCard(
                clinic: e,
                onValueChanged: (clinic) {
                  b.setclinic(e);
                },
                groupValue: b.clinic,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class ClinicSelectionCard extends StatefulWidget {
  const ClinicSelectionCard({
    super.key,
    required this.clinic,
    required this.onValueChanged,
    this.groupValue,
  });
  final Clinic clinic;
  final void Function(Clinic clinic) onValueChanged;
  final Clinic? groupValue;

  @override
  State<ClinicSelectionCard> createState() => _ClinicSelectionCardState();
}

class _ClinicSelectionCardState extends State<ClinicSelectionCard> {
  bool isSelected = false;
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    isSelected = widget.groupValue == widget.clinic;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer3<PxBookingMake, PxBookingSC, PxLocale>(
        builder: (context, b, s, l, c) {
          bool isEnglish = l.lang == 'en';
          return GestureDetector(
            onTap: () {
              widget.onValueChanged(widget.clinic);
              setState(() {
                isHovering = false;
              });
              s.scrollToPage(1, context);
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
                  child: Text(
                    isEnglish ? widget.clinic.nameEn : widget.clinic.nameAr,
                    style: Styles.TITLESTEXTSYTYLE(context),
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
