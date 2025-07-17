import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = "en"; 

  AppLanguageProvider() {
    _loadLanguageFromPrefs();
  }

  Future<void> _loadLanguageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('languageCode');
    if (savedLang != null) {
      appLanguage = savedLang;
      notifyListeners();
    }
  }

  Future<void> _saveLanguageToPrefs(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', langCode);
  }

  void changeLanguage(String newLanguage) {
    if (newLanguage == appLanguage) return;

    appLanguage = newLanguage;
    _saveLanguageToPrefs(newLanguage); 
    notifyListeners(); 
  }
}
