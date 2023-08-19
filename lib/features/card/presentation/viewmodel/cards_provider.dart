import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/card/card.dart';

class MyCardsProvider extends ChangeNotifier {
  final cardColors = [
    AppColors.textHeaderColor,
    AppColors.textHeaderColor,
    AppColors.appGreen,
  ];
  final screens = [
    const AtmCardWidget2(
      color: AppColors.textHeaderColor,
    ),
    const AtmCardWidget(
      color: AppColors.textHeaderColor,
    ),
    const AtmCardWidget3(
      color: AppColors.appGreen,
    )
  ];
}
