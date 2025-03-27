import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_website/extensions/first_where_or_null_ext.dart';
import 'package:doctor_website/extensions/model_image_url_extractor.dart';
import 'package:doctor_website/models/clinic.dart';
import 'package:doctor_website/providers/px_booking.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/components/no_items_in_list_card.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class SelectClinicSection extends StatefulWidget {
  const SelectClinicSection({super.key});

  @override
  State<SelectClinicSection> createState() => _SelectClinicSectionState();
}

class _SelectClinicSectionState extends State<SelectClinicSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PxGetDoctorData, PxBooking>(
      builder: (context, m, b, _) {
        while (m.model == null || m.model!.clinics == null) {
          return const LoadingAnimationWidget();
        }
        while (m.model!.clinics!.isEmpty) {
          return const NoItemsInListCard();
        }
        return Flex(
          direction: isMobile(context) ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 10,
          children: m.model!.clinics!.map((e) {
            return Expanded(
              child: ClinicSelectionCard(
                clinic: e.clinic,
                onValueChanged: (clinic) {
                  b.setBooking(clinic_id: e.clinic.id);
                },
                groupValue: m.model!.clinics!
                    .firstWhereOrNull(
                        (x) => x.clinic.id == b.booking!.clinic_id)
                    ?.clinic,
                style:
                    Styles(m.model?.siteSettings).SUBTITLESTEXTSYTYLE(context),
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
    required this.style,
  });
  final Clinic clinic;
  final void Function(Clinic clinic) onValueChanged;
  final Clinic? groupValue;
  final TextStyle style;

  @override
  State<ClinicSelectionCard> createState() => _ClinicSelectionCardState();
}

class _ClinicSelectionCardState extends State<ClinicSelectionCard> {
  bool isSelected = false;
  bool isHovering = false;

  @override
  void didChangeDependencies() {
    isSelected = widget.groupValue == widget.clinic;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer2<PxBookingSC, PxLocale>(
        builder: (context, s, l, _) {
          return InkWell(
            onTap: () {
              widget.onValueChanged(widget.clinic);
              setState(() {
                isHovering = false;
              });
              s.scrollToPage(1, context);
            },
            onHover: (value) {
              setState(() {
                isHovering = value;
              });
            },
            mouseCursor: SystemMouseCursors.click,
            child: Card.outlined(
              clipBehavior: Clip.antiAliasWithSaveLayer,
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
                child: (widget.clinic.image != null &&
                        widget.clinic.image!.isNotEmpty)
                    ? Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(widget.clinic
                                    .imageUrl(widget.clinic.image ?? '') ??
                                ''),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          l.isEnglish
                              ? widget.clinic.name_en
                              : widget.clinic.name_ar,
                          style: widget.style,
                        ),
                      )
                    : Text(
                        l.isEnglish
                            ? widget.clinic.name_en
                            : widget.clinic.name_ar,
                        style: widget.style,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
