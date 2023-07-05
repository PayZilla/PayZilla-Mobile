// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class OnboardingProvider extends ChangeNotifier {
  int currentValue = 0;
  double innerScrollPosition = 0;
  final welcomePageController = PageController();

  late Timer _timer;

  final onboardingScreens = const [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
  ];

  void changeCurrentValue(int value) {
    currentValue = value;
    innerScrollPosition = value.toDouble();
    notifyListeners();
  }

  void initiate() {
    _timer = Timer.periodic(3.seconds, (_) {
      welcomePageController.animateToPage(
        currentValue != 2 ? currentValue + 1 : 0,
        duration: 200.milliseconds,
        curve: Curves.easeIn,
      );
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void pushToAuthScreen(BuildContext context) {
    AppNavigator.of(context).push(AppRoutes.onboardingAuth);
    notifyListeners();
  }
}
