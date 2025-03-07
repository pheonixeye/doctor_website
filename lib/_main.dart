import 'package:doctor_website/api/get/hx_main.dart';
import 'package:doctor_website/constant/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/env/.env");

  await HxMain.common(dotenv.env[AppConstants.DOC_ID]!).fetchModelById();
}
