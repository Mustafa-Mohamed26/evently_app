import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/auth/login/login_screen.dart';
import 'package:evently_app/ui/auth/register/register_screen.dart';
import 'package:evently_app/ui/home/add_event/add_event.dart';
import 'package:evently_app/ui/home/edit_event/event_edit_screen.dart';
import 'package:evently_app/ui/home/event_details/event_details_screen.dart';
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
  // Ensure that Flutter bindings are initialized before using any widgets
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // This is necessary to use Firebase services like Firestore
  await Firebase.initializeApp(
    // Use the default Firebase options for the current platform
    // This will automatically select the correct configuration for Android, iOS, web, etc.
    options: DefaultFirebaseOptions.currentPlatform,
  ); 
  // store data on phone
  //await FirebaseFirestore.instance.disableNetwork();
  await FirebaseFirestore.instance.enableNetwork(); // Enable Firestore network to allow data storage and retrieval

  // Initialize SharedPreferences to check if the user has seen the onboarding screen
  // This is used to determine whether to show the onboarding screen or go directly to the login
  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  // If the user has not seen the onboarding screen, set it to true
  runApp(
    // Use MultiProvider to provide multiple ChangeNotifier providers to the widget tree
    // This allows different parts of the app to access shared data and state management
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => EventListProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      // The MyApp widget is the root of the application
      // It takes a boolean parameter to determine whether to show the onboarding screen
      child: MyApp(showOnboarding: !seenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    // Access the AppLanguageProvider and AppThemeProvider using Provider.of
    // This allows the app to use the current language and theme settings
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    // Access the AppThemeProvider to get the current theme mode
    // This is used to apply the correct theme to the MaterialApp
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    
    // Return a MaterialApp widget that serves as the root of the application
    // It provides localization support, routing, theming, and other app-wide configurations
    return MaterialApp(
      // Use the generated AppLocalizations class to provide localized strings
      localizationsDelegates: AppLocalizations.localizationsDelegates, // Use the generated AppLocalizations class
      supportedLocales: AppLocalizations.supportedLocales, // List of supported locales for localization
      locale: Locale(appLanguageProvider.appLanguage), // Set the current locale based on the appLanguageProvider
      
      
      debugShowCheckedModeBanner: false, // Disable the debug banner in the top right corner of the app

      // Define the initial route of the app based on whether the user has seen the onboarding screen
      // If showOnboarding is true, the app will start with the onboarding screen
      initialRoute: showOnboarding
          ? AppRoutes.onboarding1RouteName
          : AppRoutes.loginRouteName,
      routes: {
        AppRoutes.onboarding1RouteName: (context) => Onboarding1Screen(),
        AppRoutes.onboarding2RouteName: (context) => Onboarding2Screen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.addEventRouteName: (context) => AddEvent(),
        AppRoutes.eventDetailsRouteName: (context) => EventDetailsScreen(),
        AppRoutes.editEventRouteName: (context) => EventEditScreen(),
      },

      // Set the theme of the app based on the current theme mode from AppThemeProvider
      // This allows the app to switch between light and dark themes based on user preference
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeProvider.appTheme,
    );
  }
}
