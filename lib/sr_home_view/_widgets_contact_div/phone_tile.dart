import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/styles/styles.dart';

class PhoneTile extends StatelessWidget {
  const PhoneTile({
    super.key,
    required this.phone,
    required this.onTap,
  });
  final String phone;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        context.loc.phone,
        style: Styles.TITLESTEXTSYTYLE(context),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LinkText(
          phone,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Styles.ADAPTIVEFONTSIZE(context),
            color: Colors.white,
          ),
          onTap: onTap,
        ),
      ),
      dense: true,
    );
  }
}
