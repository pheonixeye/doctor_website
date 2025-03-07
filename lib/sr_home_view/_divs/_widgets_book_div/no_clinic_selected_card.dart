import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/styles/styles.dart';

class NoClinicSelectedCard extends StatelessWidget {
  const NoClinicSelectedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: Styles.CARDSHAPE,
      color: Colors.grey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            context.loc.no_clinic_selected,
            style: Styles.TITLESTEXTSYTYLE(context),
          ),
        ),
      ),
    );
  }
}

class NoDaySelectedCard extends StatelessWidget {
  const NoDaySelectedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: Styles.CARDSHAPE,
      color: Colors.grey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            context.loc.no_day_selected,
            style: Styles.TITLESTEXTSYTYLE(context),
          ),
        ),
      ),
    );
  }
}

class NoDateSelectedCard extends StatelessWidget {
  const NoDateSelectedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: Styles.CARDSHAPE,
      color: Colors.grey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            context.loc.no_date_selected,
            style: Styles.TITLESTEXTSYTYLE(context),
          ),
        ),
      ),
    );
  }
}
