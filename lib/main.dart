import 'package:doctor_website/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:doctor_website/language/app_localizations.dart';
import 'package:doctor_website/providers/_px_main.dart';
import 'package:doctor_website/providers/locale_p.dart';
import 'package:doctor_website/routes/routes.dart';
import 'package:doctor_website/styles/styles.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ar');

  await dotenv.load(fileName: "/env/.env");

  await Supabase.initialize(
    url: dotenv.env[AppConstants.SUPABASE_URL]!,
    anonKey: dotenv.env[AppConstants.SUPABASE_ANON_KEY]!,
  );

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
                child = ResponsiveBreakpoints.builder(
                  child: child!,
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
