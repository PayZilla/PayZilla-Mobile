import 'package:flutter/material.dart';

enum PZillaTab { none, home, wallet, referral, profile }

extension PZillaTabUtil on PZillaTab {
  static PZillaTab? fromString(String? tabName) {
    switch (tabName) {
      case 'home':
        return PZillaTab.home;
      case 'wallet':
        return PZillaTab.wallet;
      case 'none':
        return PZillaTab.none;
      case 'referral':
        return PZillaTab.referral;
      case 'profile':
        return PZillaTab.profile;
      default:
        return PZillaTab.home;
    }
  }
}

class PZillaTabScreenData {
  PZillaTabScreenData({required this.tab, required this.body});

  PZillaTab tab;
  Widget body;
}
