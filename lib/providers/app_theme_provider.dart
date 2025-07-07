import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  //TODO: data
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(ThemeMode newThemeMode) {
    if (appTheme == newThemeMode) {
      return;
    }
    appTheme = newThemeMode;
    notifyListeners();
  }

  bool isDarkMode(){
    return appTheme == ThemeMode.dark;
  }
}
