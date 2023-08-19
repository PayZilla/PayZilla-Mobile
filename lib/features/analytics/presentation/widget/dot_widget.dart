import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

Widget buildDot({int index = 0, int currentPage = 0}) {
  return AnimatedContainer(
    duration: kAnimationDuration,
    width: currentPage == index ? Insets.dim_10 : Insets.dim_6,
    height: currentPage == index ? Insets.dim_10 : Insets.dim_6,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: currentPage == index
          ? AppColors.textBodyColor
          : AppColors.black.withOpacity(0.4),
    ),
  );
}
