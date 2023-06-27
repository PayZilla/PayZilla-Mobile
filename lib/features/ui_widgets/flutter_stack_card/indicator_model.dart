import 'package:flutter/material.dart';

class IdicatorBuilder {
  final double displayIndicatorSize;
  final IconData displayIndicatorIcon;
  final IconData displayIndicatorActiveIcon;
  final Color displayIndicatorActiveColor;
  final Color displayIndicatorColor;

  IdicatorBuilder(
      {this.displayIndicatorSize = 24.0,
      required this.displayIndicatorIcon,
      required this.displayIndicatorActiveIcon,
      required this.displayIndicatorColor,
      required this.displayIndicatorActiveColor});
}
