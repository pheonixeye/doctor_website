import 'package:doctor_website/api/get/hx_main.dart';
import 'package:doctor_website/constant/constants.dart';
import 'package:doctor_website/providers/exp_opacity_p.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/providers/nav_index_p.dart';
import 'package:doctor_website/providers/px_get_doctor_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocale()),
  ChangeNotifierProvider(create: (context) => PxNavIndex()),
  ChangeNotifierProvider(create: (context) => PxExpOpacity()),
  ChangeNotifierProvider(
    create: (context) => PxGetDoctorData(
      service: HxMain.common(dotenv.env[AppConstants.DOC_ID]!),
    ),
  ),
];
