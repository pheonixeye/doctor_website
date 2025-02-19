import 'package:doctor_website/providers/exp_opacity_p.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/nav_index_p.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocale()),
  ChangeNotifierProvider(create: (context) => PxNavIndex()),
  ChangeNotifierProvider(create: (context) => PxExpOpacity()),
];
