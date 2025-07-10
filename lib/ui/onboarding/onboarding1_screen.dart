import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
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
  bool isEnglish = false;
  bool isLightTheme = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.appLogoOnboarding),
            Image.asset(AppAssets.onboardingScreen1),
            Text(
              AppLocalizations.of(context)!.onboarding_1_title,
              style: AppStyles.bold20Primary,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.onboarding_1_content,
              style: themeProvider.isDarkMode()
                  ? AppStyles.bold16White
                  : AppStyles.bold16Black,
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.onboarding_1_language,
                  style: AppStyles.medium20Primary,
                ),
                FlutterSwitch(
                  width: 70.0,
                  height: 35.0,
                  toggleSize: 30.0,
                  value: isEnglish,
                  borderRadius: 30.0,
                  padding: 4.0,
                  activeColor: AppColors.primaryLight,
                  inactiveColor: AppColors.primaryLight,
                  activeIcon: Iconify(CircleFlags.eg),
                  inactiveIcon: Iconify(CircleFlags.lr),
                  onToggle: (val) {
                    setState(() {
                      isEnglish = val;
                      if (!isEnglish) {
                        languageProvider.changeLanguage('en');
                      }
                      if (isEnglish) {
                        languageProvider.changeLanguage('ar');
                      }
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.onboarding_1_theme,
                  style: AppStyles.medium20Primary,
                ),
                FlutterSwitch(
                  width: 70.0,
                  height: 35.0,
                  toggleSize: 30.0,
                  value: isLightTheme,
                  borderRadius: 30.0,
                  padding: 4.0,

                  activeColor: AppColors.primaryLight,
                  inactiveColor: AppColors.primaryLight,
                  activeIcon: Iconify(
                    Typcn.adjust_contrast,
                    color: AppColors.primaryLight,
                  ), // widget,
                  inactiveIcon: Iconify(
                    Typcn.adjust_brightness,
                    color: AppColors.primaryLight,
                  ),
                  onToggle: (val) {
                    setState(() {
                      isLightTheme = val;
                      if (isLightTheme) {
                        themeProvider.changeTheme(ThemeMode.dark);
                      }
                      if (!isLightTheme) {
                        themeProvider.changeTheme(ThemeMode.light);
                      }
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.onboarding2RouteName);
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
