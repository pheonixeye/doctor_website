import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/styles/styles.dart';

class VenueTile extends StatelessWidget {
  const VenueTile({super.key, required this.venue});
  final String venue;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        context.loc.venue,
        style: Styles.TITLESTEXTSYTYLE(context),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LinkText(
          venue,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Styles.ADAPTIVEFONTSIZE(context),
            color: Colors.white,
          ),
        ),
      ),
      dense: true,
    );
  }
}
