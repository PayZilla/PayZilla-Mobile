import 'package:flutter/material.dart';

enum AppNavTab { none, home, wallet, referral, profile }

extension AppNavTabUtil on AppNavTab {
  static AppNavTab? fromString(String? tabName) {
    switch (tabName) {
      case 'home':
        return AppNavTab.home;
      case 'wallet':
        return AppNavTab.wallet;
      case 'none':
        return AppNavTab.none;
      case 'referral':
        return AppNavTab.referral;
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
