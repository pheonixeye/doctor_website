import 'package:flutter/material.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:doctor_website/styles/styles.dart';

class NoItemsInListCard extends StatelessWidget {
  const NoItemsInListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        shape: Styles.CARDSHAPE,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            context.loc.no_items_found,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
