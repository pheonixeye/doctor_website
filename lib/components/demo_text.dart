import 'package:flutter/material.dart';

class DemoText extends StatelessWidget {
  const DemoText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 48,
        color: Colors.white,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
