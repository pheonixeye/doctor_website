import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:doctor_website/exports/exports.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.address});
  final String address;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        context.loc.address,
        style: Styles.TITLESTEXTSYTYLE(context),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LinkText(
          address,
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
