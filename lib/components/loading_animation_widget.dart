import 'package:flutter/material.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/styles/styles.dart';

class LoadingAnimationWidget extends StatelessWidget {
  const LoadingAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.loc.loading,
                style: Styles.ARTICLESUBTITLESTEXTSYTYLE(context),
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
