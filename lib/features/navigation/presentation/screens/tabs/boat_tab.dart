import 'package:flutter/material.dart';

enum AppNavTab { none, home, card, activity, profile }

extension AppNavTabUtil on AppNavTab {
  static AppNavTab? fromString(String? tabName) {
    switch (tabName) {
      case 'home':
        return AppNavTab.home;
      case 'card':
        return AppNavTab.card;
      case 'none':
        return AppNavTab.none;
      case 'activity':
        return AppNavTab.activity;
      case 'profile':
        return AppNavTab.profile;
      default:
        return AppNavTab.home;
    }
  }
}

class AppTabScreenData {
  AppTabScreenData({required this.tab, required this.body});

  AppNavTab tab;
  Widget body;
}
