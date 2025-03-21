import 'package:doctor_website/functions/loc_ext_fns.dart';
import 'package:flutter/material.dart';
import 'package:doctor_website/components/link_text.dart';
import 'package:doctor_website/styles/styles.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.address, required this.style});
  final String address;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        context.loc.address,
        style: style,
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
