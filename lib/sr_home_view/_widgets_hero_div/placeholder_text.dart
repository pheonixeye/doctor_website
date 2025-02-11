import 'package:flutter/material.dart';
import 'package:doctor_website/functions/res_size.dart';

class PlaceHolderText extends StatelessWidget {
  const PlaceHolderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '',
      style: TextStyle(
        fontSize: isMobile(context) ? 26 : 42,
      ),
      textAlign: TextAlign.center,
    );
  }
}
