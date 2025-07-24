import 'package:evently_app/models/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider  extends ChangeNotifier{
  MyUser? currentUser;


  void updateUser(MyUser user){
    currentUser = user;
    notifyListeners();
  }
}