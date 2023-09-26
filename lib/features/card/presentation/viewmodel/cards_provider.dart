import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

class MyCardsProvider extends ChangeNotifier {
  Color cardColor(String cardType) {
    switch (cardType) {
      case 'visa':
        return AppColors.textHeaderColor;
      case 'mastercard':
        return AppColors.borderErrorColor;
      case 'verve':
        return AppColors.appGreen;
      default:
        return AppColors.textHeaderColor;
    }
  }
}
