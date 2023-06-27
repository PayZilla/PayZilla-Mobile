import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

final tabScreens = <PZillaTabScreenData>[
  PZillaTabScreenData(tab: PZillaTab.home, body: Container()),
  PZillaTabScreenData(tab: PZillaTab.wallet, body: Container()),
  PZillaTabScreenData(
    tab: PZillaTab.none,
    body: Container(),
  ),
  PZillaTabScreenData(
    tab: PZillaTab.referral,
    body: Container(
      color: AppColors.borderColor,
    ),
  ),
  PZillaTabScreenData(tab: PZillaTab.profile, body: Container()),
];
