import 'package:flutter/services.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

List<CountryData> phoneNumberCountryList() => [
      CountryData.empty().copyWith(
        countryName: 'Nigeria',
        countryId: 'NG',
        countryPhoneCode: '+234',
        flag: nigeriaSvg,
        currencyCode: 'NGN',
        maxLength: 11,
      ),
    ];

List<TextInputFormatter> amountInputFormatters(Money money) => [
      LengthLimitingTextInputFormatter(18),
      FilteringTextInputFormatter.digitsOnly,
      AmountInputFormatter(money),
    ];

class AmountInputFormatter extends TextInputFormatter {
  AmountInputFormatter(this.money);
  final Money money;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) return TextEditingValue.empty;
    final valueAsDouble = newValue.text.toDouble();
    final string = money.formatValue(valueAsDouble);
    return TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
