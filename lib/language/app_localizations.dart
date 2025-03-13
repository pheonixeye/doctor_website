import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'language/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @khaled_nabil.
  ///
  /// In en, this message translates to:
  /// **'Dr. Khaled Nabil'**
  String get khaled_nabil;

  /// No description provided for @homepage.
  ///
  /// In en, this message translates to:
  /// **'Homepage'**
  String get homepage;

  /// No description provided for @book_app.
  ///
  /// In en, this message translates to:
  /// **'Book Appointement'**
  String get book_app;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @beforeafter.
  ///
  /// In en, this message translates to:
  /// **'Before & After'**
  String get beforeafter;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @spec.
  ///
  /// In en, this message translates to:
  /// **'Plastic Surgery & Hair Transplantation Specialist'**
  String get spec;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow Us'**
  String get follow;

  /// No description provided for @rights.
  ///
  /// In en, this message translates to:
  /// **'All Rights Reserved @'**
  String get rights;

  /// No description provided for @design.
  ///
  /// In en, this message translates to:
  /// **'Designed & Maintained By Dr. Kareem Zaher'**
  String get design;

  /// No description provided for @media.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get media;

  /// No description provided for @venue.
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get venue;

  /// No description provided for @no_clinic_selected.
  ///
  /// In en, this message translates to:
  /// **'No Clinic Selected...Select Clinic First...'**
  String get no_clinic_selected;

  /// No description provided for @no_day_selected.
  ///
  /// In en, this message translates to:
  /// **'No Day Selected...Select Day First...'**
  String get no_day_selected;

  /// No description provided for @no_date_selected.
  ///
  /// In en, this message translates to:
  /// **'No Date Selected...Select Date First...'**
  String get no_date_selected;

  /// No description provided for @select_clinic.
  ///
  /// In en, this message translates to:
  /// **'Select Clinic'**
  String get select_clinic;

  /// No description provided for @select_weekday.
  ///
  /// In en, this message translates to:
  /// **'Pick Weekday'**
  String get select_weekday;

  /// No description provided for @select_day.
  ///
  /// In en, this message translates to:
  /// **'Pick Date'**
  String get select_day;

  /// No description provided for @select_info.
  ///
  /// In en, this message translates to:
  /// **'Enter Info'**
  String get select_info;

  /// No description provided for @booking_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed'**
  String get booking_confirmed;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error !!!'**
  String get error;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @kindly_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Your Name.'**
  String get kindly_enter_name;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name.'**
  String get enter_name;

  /// No description provided for @kindly_enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Your Mobile Number.'**
  String get kindly_enter_phone;

  /// No description provided for @enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Mobile Number.'**
  String get enter_phone;

  /// No description provided for @missing_information.
  ///
  /// In en, this message translates to:
  /// **'Missing Information'**
  String get missing_information;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @thanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for booking with'**
  String get thanks;

  /// No description provided for @to_contact.
  ///
  /// In en, this message translates to:
  /// **'You will be contacted by our reception team for confirmation.'**
  String get to_contact;

  /// No description provided for @no_items_found.
  ///
  /// In en, this message translates to:
  /// **'No Items Found'**
  String get no_items_found;

  /// No description provided for @page_not_found.
  ///
  /// In en, this message translates to:
  /// **'OOPS!!, 404 Page Not Found...'**
  String get page_not_found;

  /// No description provided for @doctor_name.
  ///
  /// In en, this message translates to:
  /// **'Dr. Hossam El-Awady'**
  String get doctor_name;

  /// No description provided for @rights_ha.
  ///
  /// In en, this message translates to:
  /// **'All Rights Reserved @Dr. Hossam El-Awady Clinics'**
  String get rights_ha;

  /// No description provided for @thanks_ha.
  ///
  /// In en, this message translates to:
  /// **'Thank you for booking with Dr. Hossam El-Awady Clinics.'**
  String get thanks_ha;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
