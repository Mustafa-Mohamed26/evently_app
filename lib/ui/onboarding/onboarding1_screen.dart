import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/widgets/custom_switch.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:colorful_iconify_flutter/icons/circle_flags.dart';
import 'package:iconify_flutter/icons/typcn.dart';
import 'package:provider/provider.dart';

class Onboarding1Screen extends StatefulWidget {
  const Onboarding1Screen({super.key});

  @override
  State<Onboarding1Screen> createState() => _Onboarding1ScreenState();
}

class _Onboarding1ScreenState extends State<Onboarding1Screen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // Access the AppLanguageProvider and AppThemeProvider using Provider.of
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    // Use provider values directly instead of local booleans
    bool isEnglish = languageProvider.appLanguage == 'en';
    bool isLightTheme = themeProvider.appTheme == ThemeMode.light;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the app logo and onboarding image
            Image.asset(AppAssets.appLogoOnboarding),
            Image.asset(AppAssets.onboardingScreen1),
            // Title and content text
            Text(
              AppLocalizations.of(context)!.onboarding_1_title,
              style: AppStyles.bold20Primary,
            ),
            SizedBox(height: height * 0.02),
            // Content text with dynamic styling based on theme
            Text(
              AppLocalizations.of(context)!.onboarding_1_content,
              style: themeProvider.isDarkMode()
                  ? AppStyles.bold16White
                  : AppStyles.bold16Black,
            ),
            SizedBox(height: height * 0.02),
            // Switch for language
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.onboarding_1_language,
                  style: AppStyles.medium20Primary,
                ),
                CustomSwitch(
                  value: isEnglish,
                  onToggle: (val) {
                    if (val) {
                      languageProvider.changeLanguage('en');
                    } else {
                      languageProvider.changeLanguage('ar');
                    }
                  },
                  activeIcon: Iconify(CircleFlags.lr),
                  inactiveIcon: Iconify(CircleFlags.eg),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            // Switch for theme selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.onboarding_1_theme,
                  style: AppStyles.medium20Primary,
                ),
                CustomSwitch(
                  value: isLightTheme,
                  onToggle: (val) {
                    if (val) {
                      themeProvider.changeTheme(ThemeMode.light);
                    } else {
                      themeProvider.changeTheme(ThemeMode.dark);
                    }
                  },
                  activeIcon: Iconify(
                    Typcn.adjust_brightness,
                    color: AppColors.primaryLight,
                  ),
                  inactiveIcon: Iconify(
                    Typcn.adjust_contrast,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
            Spacer(),
            // Continue button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
              ),
              // Navigate to the next onboarding screen
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.onboarding2RouteName,
                );
              },
              child: Text(
                AppLocalizations.of(context)!.onboarding_1_button,
                style: AppStyles.medium20White,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
