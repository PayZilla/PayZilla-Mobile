import 'package:flutter/material.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class ProfileProvider extends ChangeNotifier {
  //create the profile widget data
  final profileWidget = [
    ProfileWidgetData(
      title: 'Referral Code',
      asset: referralSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.referral),
    ),
    ProfileWidgetData(
      title: 'Account Info',
      asset: accountInfoSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.accountInfo),
    ),
    ProfileWidgetData(
      title: 'Contact List',
      asset: contactListSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.contact),
    ),
    ProfileWidgetData(
      title: 'Language',
      asset: languageSvg,
      todo: (context) {
        Log().debug('Language');
      },
    ),
    ProfileWidgetData(
      title: 'General Setting',
      asset: generalSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.general),
    ),
    ProfileWidgetData(
      title: 'Change Password',
      asset: passwordSvg,
      todo: (context) {
        Log().debug('Change Password');
      },
    ),
    ProfileWidgetData(
      title: 'FAQ',
      asset: passwordSvg,
      todo: (context) => AppNavigator.of(context).push(AppRoutes.faq),
    ),
  ];
}

class ProfileWidgetData {
  ProfileWidgetData({
    required this.title,
    required this.asset,
    required this.todo,
  });

  final String title;
  final String asset;
  final Function(BuildContext context)? todo;
}
