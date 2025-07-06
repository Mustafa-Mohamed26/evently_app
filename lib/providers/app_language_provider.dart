import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier{
  //TODO: the data and mothods will be added
  String appLanguage = "en";

  //TODO: change the language
  void changeLanguage(String newLanguage){
    if(newLanguage == appLanguage){
      return;
    }
    //TODO: appLanguage => defult => current language
    //TODO: newLamguage => selected language
    appLanguage = newLanguage;
    //TODO: notify the listeners
    notifyListeners();
  }
}