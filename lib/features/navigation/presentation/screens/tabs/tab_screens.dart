import 'package:flutter/material.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

final tabScreens = <AppTabScreenData>[
  AppTabScreenData(tab: AppNavTab.home, body: const DashboardScreen()),
  AppTabScreenData(tab: AppNavTab.card, body: Container()),
  AppTabScreenData(tab: AppNavTab.none, body: Container()),
  AppTabScreenData(tab: AppNavTab.activity, body: Container()),
  AppTabScreenData(tab: AppNavTab.profile, body: Container()),
];
