import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/card/card.dart';

class MyCardsProvider extends ChangeNotifier {
  final cardColors = [
    AppColors.textHeaderColor,
    AppColors.textHeaderColor,
    const Color(0xff1DAB87),
  ];
  final screens = [
    const AtmCardWidget2(
      color: AppColors.textHeaderColor,
    ),
    const AtmCardWidget(
      color: AppColors.textHeaderColor,
    ),
    const AtmCardWidget3(
      color: Color(0xff1DAB87),
    )
  ];
}
