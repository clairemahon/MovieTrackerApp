import 'package:flutter/material.dart';
import 'package:minichallenge3/models/user.dart';

// UserManager is a ChangeNotifier that holds the state of the user settings profile
class UserManager extends ChangeNotifier {
  User get getUser => User(
        userName: 'movielover2',
        firstName: 'Stefano',
        lastName: 'Patt',
        country: 'Spain',
        language: 'English',
        profileImageUrl: 'assets/randompersonface.jpeg',
        darkMode: _darkMode,
      );

  bool get didSelectUser => _didSelectUser;
  bool get darkMode => _darkMode;

  var _didSelectUser = false;
  var _darkMode = false;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
