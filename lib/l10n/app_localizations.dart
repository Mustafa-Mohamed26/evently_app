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
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @onboarding_1_title.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get onboarding_1_title;

  /// No description provided for @onboarding_1_content.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get onboarding_1_content;

  /// No description provided for @onboarding_1_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get onboarding_1_language;

  /// No description provided for @onboarding_1_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get onboarding_1_theme;

  /// No description provided for @onboarding_1_button.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get onboarding_1_button;

  /// No description provided for @onboarding_2_title.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get onboarding_2_title;

  /// No description provided for @onboarding_2_content.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get onboarding_2_content;

  /// No description provided for @onboarding_3_title.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get onboarding_3_title;

  /// No description provided for @onboarding_3_content.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get onboarding_3_content;

  /// No description provided for @onboarding_4_title.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get onboarding_4_title;

  /// No description provided for @onboarding_4_content.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get onboarding_4_content;

  /// No description provided for @onboarding_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboarding_back;

  /// No description provided for @onboarding_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next;

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @onboarding_finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get onboarding_finish;

  /// No description provided for @login_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_email;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password;

  /// No description provided for @login_forget.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get login_forget;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_button;

  /// No description provided for @login_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have Account ?'**
  String get login_account;

  /// No description provided for @login_create.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get login_create;

  /// No description provided for @login_or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get login_or;

  /// No description provided for @login_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_google;

  /// No description provided for @login_empty_email.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Email'**
  String get login_empty_email;

  /// No description provided for @login_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Email'**
  String get login_valid_email;

  /// No description provided for @login_empty_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Password'**
  String get login_empty_password;

  /// No description provided for @login_6_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get login_6_characters;

  /// No description provided for @loading_login.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading_login;

  /// No description provided for @loading_google.
  ///
  /// In en, this message translates to:
  /// **'Signing in with Google...'**
  String get loading_google;

  /// No description provided for @login_success.
  ///
  /// In en, this message translates to:
  /// **'Login success'**
  String get login_success;

  /// No description provided for @login_success_title.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get login_success_title;

  /// No description provided for @login_success_action.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get login_success_action;

  /// No description provided for @google_login_success.
  ///
  /// In en, this message translates to:
  /// **'Google login successful'**
  String get google_login_success;

  /// No description provided for @google_login_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in was cancelled or failed.'**
  String get google_login_cancelled;

  /// No description provided for @error_title.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_title;

  /// No description provided for @error_invalid_credential.
  ///
  /// In en, this message translates to:
  /// **'The supplied auth credential is incorrect, malformed or has expired.'**
  String get error_invalid_credential;

  /// No description provided for @error_no_internet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get error_no_internet;

  /// No description provided for @error_firebase.
  ///
  /// In en, this message translates to:
  /// **'Firebase error occurred'**
  String get error_firebase;

  /// No description provided for @register_Title.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register_Title;

  /// No description provided for @register_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get register_name;

  /// No description provided for @register_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get register_email;

  /// No description provided for @register_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get register_password;

  /// No description provided for @register_rePassword.
  ///
  /// In en, this message translates to:
  /// **'Re Password'**
  String get register_rePassword;

  /// No description provided for @register_button.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get register_button;

  /// No description provided for @register_have.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ?'**
  String get register_have;

  /// No description provided for @register_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get register_login;

  /// No description provided for @register_empty_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get register_empty_name;

  /// No description provided for @register_empty_repassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password again'**
  String get register_empty_repassword;

  /// No description provided for @register_password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get register_password_not_match;

  /// No description provided for @register_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get register_loading;

  /// No description provided for @register_success.
  ///
  /// In en, this message translates to:
  /// **'Registration success'**
  String get register_success;

  /// No description provided for @register_success_title.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get register_success_title;

  /// No description provided for @register_success_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get register_success_ok;

  /// No description provided for @register_email_exists.
  ///
  /// In en, this message translates to:
  /// **'The account already exists for that email. Please login'**
  String get register_email_exists;

  /// No description provided for @register_error_title.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get register_error_title;

  /// No description provided for @register_no_internet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get register_no_internet;

  /// No description provided for @register_weak_password.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak.'**
  String get register_weak_password;

  /// No description provided for @forgetPassword_title.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword_title;

  /// No description provided for @forgetPassword_button.
  ///
  /// In en, this message translates to:
  /// **'Rest Password'**
  String get forgetPassword_button;

  /// No description provided for @home_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get home_welcome;

  /// No description provided for @home_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get home_all;

  /// No description provided for @home_sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get home_sport;

  /// No description provided for @home_birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get home_birthday;

  /// No description provided for @love_search.
  ///
  /// In en, this message translates to:
  /// **'Search for Event'**
  String get love_search;

  /// No description provided for @profile_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profile_language;

  /// No description provided for @profile_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get profile_english;

  /// No description provided for @profile_arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get profile_arabic;

  /// No description provided for @profile_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profile_theme;

  /// No description provided for @profile_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get profile_light;

  /// No description provided for @profile_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get profile_dark;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_logout;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get love;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @category_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get category_all;

  /// No description provided for @category_sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get category_sport;

  /// No description provided for @category_birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get category_birthday;

  /// No description provided for @category_meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get category_meeting;

  /// No description provided for @category_gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get category_gaming;

  /// No description provided for @category_workshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get category_workshop;

  /// No description provided for @category_bookclub.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get category_bookclub;

  /// No description provided for @category_exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get category_exhibition;

  /// No description provided for @category_holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get category_holiday;

  /// No description provided for @category_eating.
  ///
  /// In en, this message translates to:
  /// **'Eating'**
  String get category_eating;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
