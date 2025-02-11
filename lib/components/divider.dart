import 'package:flutter/material.dart';

class GlobalDivider extends StatelessWidget {
  const GlobalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        child: const Center(
          child: Icon(
            Icons.star,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
