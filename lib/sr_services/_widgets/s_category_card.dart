import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_website/constant/male_female.dart';
import 'package:doctor_website/pages/pages.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';

class ServicesCategoryCard extends StatefulWidget {
  const ServicesCategoryCard({super.key, required this.category});
  final MF category;

  @override
  State<ServicesCategoryCard> createState() => _ServicesCategoryCardState();
}

class _ServicesCategoryCardState extends State<ServicesCategoryCard> {
  //todo: animate & customize container
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onHover: (value) {
            setState(() {
              isHovering = value;
            });
          },
          onTap: () {
            //todo: add on click call fetch services from api according to category male or female
            GoRouter.of(context).push(
                '/${context.read<PxLocale>().lang}/${PageNumbers.ServicesView.i}/${widget.category.en}');
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Card(
              elevation: 20,
              shape: Styles.CARDSHAPE,
              color: Colors.grey,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    isHovering
                        ? 'assets/images/${widget.category.en}c.jpg'
                        : 'assets/images/${widget.category.en}.jpg',
                    fit: BoxFit.cover,
                  ),
                  Consumer<PxLocale>(
                    builder: (context, l, c) {
                      bool isEnglish = l.lang == 'en';
                      return Text(
                        isEnglish
                            ? widget.category.en.toUpperCase()
                            : widget.category.ar,
                        style: Styles.ARTICLETITLESTEXTSYTYLE(context),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
