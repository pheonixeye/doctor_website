import 'package:flutter/material.dart';
import 'package:doctor_website/functions/loc_ext_fns.dart';

class MxNavigation {
  final Icon icon;
  final Text text;
  final EdgeInsets padding;

  MxNavigation({
    required this.icon,
    required this.text,
    this.padding = const EdgeInsets.all(8),
  });

  static List<MxNavigation> NAVITEMS(BuildContext context) => [
        MxNavigation(
          icon: const Icon(Icons.home),
          text: Text(context.loc.homepage),
        ),
        MxNavigation(
          icon: const Icon(Icons.calendar_month),
          text: Text(
            context.loc.book_app,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        MxNavigation(
          icon: const Icon(Icons.design_services),
          text: Text(context.loc.services),
        ),
        MxNavigation(
          icon: const Icon(Icons.people_rounded),
          text: Text(
            context.loc.beforeafter,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        MxNavigation(
          icon: const Icon(Icons.video_collection),
          text: Text(
            context.loc.media,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        MxNavigation(
          icon: const Icon(Icons.file_copy),
          text: Text(context.loc.articles),
        ),
        MxNavigation(
          icon: const Icon(Icons.contact_phone),
          text: Text(context.loc.contact),
        ),
        MxNavigation(
          icon: const Icon(Icons.add_reaction_sharp),
          text: Text(context.loc.about),
        ),
      ];
}
