import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

class AnalyticProvider extends ChangeNotifier {
  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40)
  ];

  final List<Color> _sliders = [
    AppColors.borderErrorColor,
    AppColors.appSecondaryColor,
    AppColors.textHeaderColor,
  ];
  List<Color> get sliders => _sliders;
  int currentSliderIndex = 0;
  PageController pageController = PageController();
  void onSliderChange(int index) {
    currentSliderIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
