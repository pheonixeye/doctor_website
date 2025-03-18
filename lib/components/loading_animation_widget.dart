import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class LoadingAnimationWidget extends StatelessWidget {
  const LoadingAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxGetDoctorData>(
      builder: (context, m, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.loc.loading,
                style:
                    Styles(m.model?.siteSettings).SUBTITLESTEXTSYTYLE(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
