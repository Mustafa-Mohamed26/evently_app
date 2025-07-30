import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:evently_app/providers/app_theme_provider.dart';

class Onboarding2Screen extends StatefulWidget {
  const Onboarding2Screen({super.key});

  @override
  State<Onboarding2Screen> createState() => _Onboarding2ScreenState();
}

class _Onboarding2ScreenState extends State<Onboarding2Screen> {
  // Global key for the IntroductionScreen state
  // This key is used to control the state of the introduction screen
  final introKey = GlobalKey<IntroductionScreenState>();

  // This method builds an image widget with a specified asset name and width
  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }

  // This method is called when the introduction is completed
  // It saves a preference indicating that the user has seen the onboarding screen
  Future<void> _completeOnboarding(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('seenOnboarding', true);
  if (context.mounted) {
    Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
  }
}

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    
    // Define the page decoration for the introduction screen
    // This includes styles for the title, body text, background color, and image alignment
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: AppStyles.bold20Primary,
      bodyTextStyle: themeProvider.isDarkMode()
          ? AppStyles.bold16White
          : AppStyles.bold16Black,
      pageColor: themeProvider.isDarkMode()
          ? AppColors.blackColor
          : AppColors.whiteBgColor,
      imagePadding: EdgeInsets.zero,
      imageAlignment: Alignment.bottomCenter,
      imageFlex: 2,
      bodyFlex: 1,
      bodyAlignment: Alignment.bottomCenter,
    );
    // Build the introduction screen using the IntroductionScreen widget
    // This widget provides a customizable introduction experience with multiple pages
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: themeProvider.isDarkMode()
          ? AppColors.blackColor
          : AppColors.whiteBgColor,
      //allowImplicitScrolling: true,
      //autoScrollDuration: 3000,
      infiniteAutoScroll: false,
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(child: _buildImage(AppAssets.appLogoOnboarding, 400)),
      ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),

      // Define the pages for the introduction screen
      pages: [
        PageViewModel(
          title: AppLocalizations.of(context)!.onboarding_2_title,
          body: AppLocalizations.of(context)!.onboarding_2_content,
          image: _buildImage(AppAssets.onboardingScreen2),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboarding_3_title,
          body: AppLocalizations.of(context)!.onboarding_3_content,
          image: _buildImage(AppAssets.onboardingScreen3),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboarding_4_title,
          body: AppLocalizations.of(context)!.onboarding_4_content,
          image: _buildImage(AppAssets.onboardingScreen4),
          decoration: pageDecoration,
        ),
      ],

      // Define the actions for the introduction screen
      // These actions include the next, back, skip, and done buttons
      onDone: () => _completeOnboarding(context),
      onSkip: () => _completeOnboarding(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left

      // Define the styles for the buttons
      back: Text(
        AppLocalizations.of(context)!.onboarding_back,
        style: AppStyles.bold16Primary,
      ),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: Text(
        AppLocalizations.of(context)!.onboarding_next,
        style: AppStyles.bold16Primary,
      ),
      done: Text(
        AppLocalizations.of(context)!.onboarding_finish,
        style: AppStyles.bold16Primary,
      ),

      // Define the styles for the dots and controls
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: AppColors.primaryLight,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
