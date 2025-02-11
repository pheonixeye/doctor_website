import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/functions/res_size.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:provider/provider.dart';
import 'package:doctor_website/exports/exports.dart';

class ServicesHeroButton extends StatefulWidget {
  const ServicesHeroButton({super.key});

  @override
  State<ServicesHeroButton> createState() => _ServicesHeroButtonState();
}

class _ServicesHeroButtonState extends State<ServicesHeroButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _duration = const Duration(milliseconds: 5000);
  late Animation<double> _animation;
  late Animation<double> _changeValue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _animate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _animate() {
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _changeValue = Tween(begin: 0.0, end: 1.0).animate(_animation);
    _controller.forward(from: 0.0);
    _changeValue.addListener(() {
      setState(() {});
    });
    _changeValue.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(_duration);
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 300.0 / (_changeValue.value * 6),
      ),
      child: ElevatedButton(
        onPressed: () {
          GoRouter.of(context).go('/${context.read<PxLocale>().lang}/2');
        },
        child: Padding(
          padding: EdgeInsets.all(isMobile(context) ? 8 : 16),
          child: Text(
            context.loc.services,
            style: TextStyle(
              fontSize: isMobile(context) ? 14 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
