import 'package:doctor_website/providers/px_booking.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:doctor_website/components/error_catcher_dialog.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/sr_home_view/_divs/_widgets_book_div/no_clinic_selected_card.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class EnterCredentialsConfirmBookingSection extends StatefulWidget {
  const EnterCredentialsConfirmBookingSection({super.key});

  @override
  State<EnterCredentialsConfirmBookingSection> createState() =>
      _EnterCredentialsConfirmBookingSectionState();
}

class _EnterCredentialsConfirmBookingSectionState
    extends State<EnterCredentialsConfirmBookingSection> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer3<PxGetDoctorData, PxBooking, PxBookingSC>(
      builder: (context, m, b, sc, c) {
        while (m.model == null ||
            m.model!.clinics == null ||
            m.model!.clinics!.isEmpty ||
            b.booking == null) {
          return const LoadingAnimationWidget();
        }
        while (b.booking!.clinic_id == null) {
          return const NoClinicSelectedCard();
        }
        while (b.booking!.schedule_id == null) {
          return const NoDaySelectedCard();
        }
        while (b.booking!.date == null) {
          return const NoDateSelectedCard();
        }
        return Form(
          key: formKey,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 10,
                shape: Styles.CARDSHAPE,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: TextFormField(
                    onChanged: (value) {
                      b.setBooking(name: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.loc.kindly_enter_name;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefix: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.person),
                      ),
                      labelText: context.loc.name,
                      hintText: context.loc.enter_name,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shape: Styles.CARDSHAPE,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: TextFormField(
                    onChanged: (value) {
                      b.setBooking(phone: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.loc.kindly_enter_phone;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefix: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.mobile_friendly),
                      ),
                      labelText: context.loc.phone,
                      hintText: context.loc.enter_phone,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
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
                        icon: const Icon(Icons.check),
                        label: Text(context.loc.confirm),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              b.verifyBooking();
                            } catch (e) {
                              await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return ErrorCatcherDialog(
                                    errorText: context.loc.missing_information,
                                  );
                                },
                              );
                              return;
                            }
                            if (context.mounted) {
                              await EasyLoading.show(
                                      status: context.loc.loading)
                                  .then((value) async {
                                await b.createBooking().then((value) {
                                  if (context.mounted) {
                                    sc.scrollToPage(4, context);
                                  }
                                }).then((value) async {
                                  await EasyLoading.dismiss();
                                });
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
