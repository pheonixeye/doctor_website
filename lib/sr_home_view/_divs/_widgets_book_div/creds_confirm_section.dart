import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:doctor_website/components/error_catcher_dialog.dart';
import 'package:doctor_website/components/loading_animation_widget.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/providers/px_booking_make.dart';
import 'package:doctor_website/providers/px_booking_s_c.dart';
import 'package:doctor_website/providers/px_clinics_get.dart';
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
    return Consumer3<PxClinicGet, PxBookingMake, PxBookingSC>(
      builder: (context, cl, b, sc, c) {
        while (cl.clinics == null || cl.clinics!.isEmpty) {
          return const LoadingAnimationWidget();
        }
        while (b.clinic == null) {
          return const NoClinicSelectedCard();
        }
        while (b.day == null) {
          return const NoDaySelectedCard();
        }
        while (b.date == null) {
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
                      b.setptName(value);
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
                      b.setptPhone(value);
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
                              b.setbooking();
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
                                await b.addBooking().then((value) {
                                  sc.scrollToPage(4, context);
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
