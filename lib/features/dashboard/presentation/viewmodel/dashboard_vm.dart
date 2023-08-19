import 'package:flutter/material.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

class DashboardProvider extends ChangeNotifier {
  // routes for dashboard actions

  void goTo(String routeName, BuildContext context) {
    AppNavigator.of(context).push(routeName);
  }
}
