import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyFormat {
  static final currencyFormat = NumberFormat('#,##0.00', 'en_US');

  static String formatStringToCurrency(String value) {
    return currencyFormat.format(double.tryParse(value));
  }

  static String formatStringToCurrencyRound(String value) {
    final amount = double.tryParse(value);
    if (amount != null && amount >= 100) {
      final altFormat = NumberFormat('#,##0', 'en_US');
      return altFormat.format(amount.round());
    }
    return amount.toString();
  }

  static String formatPercentage(double value, BuildContext context) {
    final myLocale = Localizations.localeOf(
      context,
    ); /* gets the locale based on system language*/
    final languageCode = myLocale.languageCode;
    final percentFormat = NumberFormat.percentPattern(languageCode);
    return percentFormat.format(value);
  }

  static double roundDouble(double value, int places) {
    final mod = pow(10.0, places);
    return (value * mod).round().toDouble() / mod;
  }
}
