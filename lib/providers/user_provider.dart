import 'package:evently_app/models/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider  extends ChangeNotifier{
  // This provider holds the current user data
  // It allows the app to access and update user information throughout the app
  MyUser? currentUser;


  // This method updates the current user data
  // It takes a MyUser object as a parameter and updates the currentUser variable
  void updateUser(MyUser user){
    currentUser = user;
    notifyListeners();
  }
}