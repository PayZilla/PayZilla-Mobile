import 'package:flutter/material.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

final tabScreens = <AppTabScreenData>[
  AppTabScreenData(tab: AppNavTab.home, body: Container()),
  AppTabScreenData(tab: AppNavTab.wallet, body: Container()),
  AppTabScreenData(tab: AppNavTab.none, body: Container()),
  AppTabScreenData(tab: AppNavTab.referral, body: Container()),
  AppTabScreenData(tab: AppNavTab.profile, body: Container()),
];
