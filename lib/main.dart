import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:doctor_website/config/const.dart';
import 'package:doctor_website/language/app_localizations.dart';
import 'package:doctor_website/providers/_px_main.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/routes/routes.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.PROD,
  );
  // print(environment);
  Environment().initConfig(environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return Consumer<PxLocale>(
          builder: (context, l, c) {
            return MaterialApp.router(
              title: 'Dr. Hossam El-Awady',
              debugShowCheckedModeBanner: false,
              theme: Styles.LIGHTTHEMEDATA(context),
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              builder: (context, child) {
                child = EasyLoading.init()(context, child);
                child = ResponsiveBreakpoints.builder(
                  child: child,
                  breakpoints: const [
                    Breakpoint(start: 0, end: 450, name: MOBILE),
                    Breakpoint(start: 451, end: 800, name: TABLET),
                    Breakpoint(start: 801, end: 1920, name: DESKTOP),
                    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                  ],
                );
                return child;
              },
              locale: l.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
