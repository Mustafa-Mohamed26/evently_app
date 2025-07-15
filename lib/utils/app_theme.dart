import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteBgColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Black,
      headlineMedium: AppStyles.medium16Primary,
      headlineSmall: AppStyles.medium16White,
      titleLarge: AppStyles.medium16Black,
      titleMedium: AppStyles.medium16Gray,
    ),
    primaryColor: AppColors.primaryLight,
    focusColor: AppColors.whiteColor,
    dividerColor: AppColors.greyColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.primaryLight),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
        side: BorderSide(color: AppColors.whiteColor, width: 4),
      ),
      // StadiumBorder() => circular shape
      elevation: 0,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryDark,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20White,
      headlineMedium: AppStyles.medium16White,
      headlineSmall: AppStyles.medium16White,
      titleLarge: AppStyles.medium16White,
      titleMedium: AppStyles.medium16White,
    ),
    primaryColor: AppColors.primaryDark,
    focusColor: AppColors.primaryLight,
    dividerColor: AppColors.whiteColor,

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.primaryDark),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
        side: BorderSide(color: AppColors.whiteColor, width: 4),
      ),
      // StadiumBorder() => circular shape
      elevation: 0,
    ),
  );
}
