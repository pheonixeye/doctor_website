import 'package:flutter/material.dart';
import 'package:doctor_website/config/const.dart';

class SubRouteBackground extends StatelessWidget {
  const SubRouteBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Opacity(
        opacity: 0.8,
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bkgrnd_${Initials.i_}.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
