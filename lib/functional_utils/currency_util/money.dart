import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class Money {
  factory Money([CurrencyModel? currency]) {
    return Money._(currency ?? ngn);
  }

  Money._(CurrencyModel currency)
      : _currency = currency,
        _formatter = NumberFormat.currency(
          name: currency.name,
          symbol: '${currency.shortName} ',
          locale: currency.locale,
          decimalDigits: currency.minorUnits,
        );
  final NumberFormat _formatter;
  final CurrencyModel _currency;

  /// returns a money instance without currency shortName/symbol
  Money normalized() => Money(_currency.copyWith(shortName: ''));

  int get scaleFactor => math.pow(10, _currency.minorUnits).round();

  /// use this to to get the integral value of a monetary input
  /// Eg usd $1.24 becomes 124 cents and vice versa for Naira to Kobo
  int getValue(num input) => (input * scaleFactor).round();
  String formatValue(dynamic input) {
    num temp;
    if (input == null) return _formatter.format(0 / scaleFactor);
    if (input.toString().contains('-')) {
      temp = double.parse(
        input
            .toString()
            .substring(1)
            .replaceAll(RegExp('[A-Za-b]+'), '')
            .replaceAll(',', '')
            .trim(),
      );
    } else {
      temp = double.parse(
        input
            .toString()
            .replaceAll(RegExp('[A-Za-b]+'), '')
            .replaceAll(',', '')
            .trim(),
      );
    }

    return _formatter.format(temp / scaleFactor);
  }

  int sanitizeAmount(String? value) {
    if (value == null) return 0;
    try {
      value.replaceAll(RegExp('[A-Za-b]+'), '').replaceAll(',', '').trim();
      final sanitizedAmount = getValue(double.parse(value));
      return sanitizedAmount;
    } catch (_) {
      return 0;
    }
  }
}

class CurrencyModel {
  const CurrencyModel({
    required this.name,
    required this.shortName,
    required this.locale,
    required this.minorUnits,
    required this.flag,
  });
  final String name;
  final String shortName;
  final String locale;
  final int minorUnits;
  final String flag;

  CurrencyModel copyWith({
    String? name,
    String? shortName,
    String? locale,
    int? minorUnits,
    String? flag,
  }) {
    return CurrencyModel(
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      locale: locale ?? this.locale,
      minorUnits: minorUnits ?? this.minorUnits,
      flag: flag ?? this.flag,
    );
  }
}

final ngn = CurrencyModel(
  name: 'naira',
  shortName: 'NGN',
  locale: 'en_NG',
  minorUnits:
      2, //https://help.sap.com/doc/d847860d561a47568a936d5f3cbeb9da/4.1/en-US/core_tool/Tools_MENU/Currencies/About_currencies.htm#:~:text=The%20minor%20currency%20unit%20has,have%20no%20minor%20currency%20unit.
  flag: nigeriaSvg,
);

final cad = CurrencyModel(
  name: 'canadian dollars',
  shortName: 'CAD',
  locale: 'en_CA',
  minorUnits: 1,
  flag: canadaSvg,
);

List<CurrencyModel> supportedCurrencyList() => [ngn];
