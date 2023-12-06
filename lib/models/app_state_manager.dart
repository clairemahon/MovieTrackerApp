import 'dart:async';
import 'package:flutter/material.dart';
import 'package:minichallenge3/models/app_cache.dart';

class CineScreenTab {
  static const int trending = 0;
  static const int myprofile = 1;
  static const int search = 2;
}

// AppStateManager mocks the various app states: initialization and tabs
class AppStateManager extends ChangeNotifier {
  // Records the current tab the user is on.
  int _selectedTab = CineScreenTab.trending;
  // Stores user state properties on platform specific file system.
  final _appCache = AppCache();

  // Property getters.
  int get getSelectedTab => _selectedTab;

  // Initializes the app
  Future<void> initializeApp() async {
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToProfile() {
    _selectedTab = CineScreenTab.myprofile;
    notifyListeners();
  }

  void goToSearch() {
    _selectedTab = CineScreenTab.search;
    notifyListeners();
  }
}
