import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/data/core_data.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

FutureBottomSheet<CountryData> showCountry({
  bool dismissible = true,
  void Function(CountryData)? onTap,
  required BuildContext context,
  required AuthProvider provider,
}) {
  return FutureBottomSheet<CountryData>(
    future: () => Future.value(registeringCountries),
    height: context.getHeight(0.2),
    isDismissible: dismissible,
    itemBuilder: (context, item) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          item.countryName.capitalize(),
          style: const TextStyle(fontSize: 15),
        ),
        leading: LocalSvgImage(
          item.flag,
          height: Insets.dim_24.dy,
          width: Insets.dim_24.dx,
        ),
        onTap: () {
          if (onTap == null) {
            provider.countrySelected(item, context);
          } else {
            onTap(item);
            AppNavigator.of(context).popDialog();
          }
        },
      );
    },
  );
}

// get started button
final registeringCountries = [
  CountryData(
    countryId: 'NG',
    countryName: 'Nigeria',
    currencyCode: 'NGN',
    flag: nigeriaSvg,
    slug: 'Nigerian',
    applicationType: 4,
    countryPhoneCode: '+234',
    maxLength: 11,
  ),
];
