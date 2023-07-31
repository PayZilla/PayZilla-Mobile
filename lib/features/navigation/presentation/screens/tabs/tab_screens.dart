import 'package:flutter/material.dart';
import 'package:pay_zilla/features/analytics/analytics.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';

final tabScreens = <AppTabScreenData>[
  AppTabScreenData(tab: AppNavTab.home, body: const DashboardScreen()),
  AppTabScreenData(tab: AppNavTab.card, body: const MyCardScreen()),
  AppTabScreenData(tab: AppNavTab.none, body: Container()),
  AppTabScreenData(tab: AppNavTab.activity, body: const AnalyticsScreen()),
  AppTabScreenData(tab: AppNavTab.profile, body: const ProfileScreen()),
];
