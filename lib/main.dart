import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/auth/login/login_screen.dart';
import 'package:evently_app/ui/auth/register/register_screen.dart';
import 'package:evently_app/ui/home/add_event/add_event.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/onboarding/onboarding1_screen.dart';
import 'package:evently_app/ui/onboarding/onboarding2_screen.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //to ensure that the widgets are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // store data on phone
  await FirebaseFirestore.instance.disableNetwork();

  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => EventListProvider()),
      ],
      child: MyApp(showOnboarding: !seenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appLanguageProvider.appLanguage),
      debugShowCheckedModeBanner: false,
      initialRoute: showOnboarding
          ? AppRoutes.onboarding1RouteName
          : AppRoutes.homeRouteName,
      routes: {
        AppRoutes.onboarding1RouteName: (context) => Onboarding1Screen(),
        AppRoutes.onboarding2RouteName: (context) => Onboarding2Screen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.addEventRouteName: (context) => AddEvent(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeProvider.appTheme,
    );
  }
}
